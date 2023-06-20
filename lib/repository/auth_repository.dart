import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/local/dao/role_dao.dart';
import 'package:antreeorder/config/remote/response/login_response.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/account.dart';
import 'package:antreeorder/models/role.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<ResponseResult<User>> register(User user);
  Future<ResponseResult<User>> login(User user);
  Future<List<Role>> getRoles();
  Future<ResponseResult<String>> onLogOut();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final Dio _dio;
  final RoleDao _roleDao;

  @factoryMethod
  AuthRepositoryImpl(
      this._apiClient, this._sharedPrefsRepository, this._dio, this._roleDao);

  @override
  Future<List<Role>> getRoles() async {
    var roles = <Role>[];
    roles = await _roleDao.roles();

    if (roles.isNotEmpty) return roles;

    try {
      final response = await _apiClient.auth.getRoles();
      roles = response.roles;
      if (roles.isNotEmpty) {
        for (var element in roles) {
          _roleDao.addRole(element);
        }
      }
    } catch (e) {
      roles = [
        Role(
            id: 1,
            name: 'Customer',
            description: 'Default role given to authenticated user.'),
        Role(id: 3, name: 'Merchant', description: 'for merchant')
      ];
    }
    logger.d(roles);
    return roles;
  }

  @override
  Future<ResponseResult<User>> login(User user) async {
    _dio.options.headers = {"Authorization": ""};
    Account account = Account();

    final response = await _apiClient.auth.login(user.toLogin).awaitResponse;

    final loginResponse = response.whenOrNull(
      data: (data, meta) => data,
    );

    if (response is ResponseResultError<LoginResponse> ||
        loginResponse == null) {
      final errorMessage = response.whenOrNull(
        error: (message) => message,
      );
      return ResponseResult.error(errorMessage ?? 'Error Login');
    }

    final jwt = loginResponse.jwt;
    User newUser = loginResponse.user;

    if (jwt.isEmpty && newUser.id == 0)
      return ResponseResult.error('Error empty account');

    _dio.options.headers = {"Authorization": "Bearer $jwt"};
    account = account.copyWith(token: jwt);

    //===== notification token =====
    logger.i('===== notification token =====');
    final notifToken =
        await getIt<FirebaseMessaging>().getToken().then((value) => value);
    if (notifToken == null || notifToken.isEmpty)
      return ResponseResult.error('Cant get notification token');
    BaseBody mapToken = {'notificationToken': notifToken};
    final notifResponse =
        await _apiClient.auth.updateUser(newUser.id, mapToken).awaitResponse;
    if (notifResponse is ResponseResultError<User>) return notifResponse;
    //=======================

    final responseMe =
        await _apiClient.auth.detailUser(newUser.id).awaitResponse;

    newUser = responseMe.whenOrNull(
          data: (data, meta) => data,
        ) ??
        newUser;
    account =
        account.copyWith(isMerchant: newUser.role.isMerchant, user: newUser);

    if (account.user.role.id == 0) {
      return ResponseResult.error('Empty Role for this account');
    }

    if (account.isMerchant == true && account.user.merchantId == 0) {
      return ResponseResult.error('Empty Merchant Id');
    }
    if (account.isMerchant == false && account.user.customerId == 0) {
      return ResponseResult.error('Empty Customer Id');
    }
    _sharedPrefsRepository.account = account;
    return responseMe;
  }

  @override
  Future<ResponseResult<User>> register(User user) async {
    bool isNextRequest = true;
    ResponseResult<User> result = const ResponseResult.error('EMPTY');

    final registerResponse =
        await _apiClient.auth.register(user.toRegister).awaitResponse;
    registerResponse.whenOrNull(
      data: (data, meta) {
        user = user.copyWith(id: data.id);
        result = ResponseResult.data(data, meta);
      },
      error: (message) {
        result = ResponseResult.error(message);
        isNextRequest = false;
      },
    );

    // register merchant
    if (user.role.isMerchant && isNextRequest) {
      final merchantResponse =
          await _apiClient.auth.addMerchant().awaitResponse;
      merchantResponse.whenOrNull(
        data: (merchant, meta) async {
          final merchantId = merchant.id;
          user = user.copyWith(merchantId: merchantId);
        },
        error: (message) {
          result = ResponseResult.error(message);
          isNextRequest = false;
        },
      );

      final merchantId = user.merchantId;
      if (merchantId != 0) {
        final responseMerchant = await _apiClient.auth
            .updateMerchant(merchantId, user.toRegisterUserId)
            .awaitResponse;
        responseMerchant.whenOrNull(
          data: (data, meta) => logger.d('Update Merchant -> $data'),
          error: (message) {
            result = ResponseResult.error(message);
            isNextRequest = false;
            return result;
          },
        );
      } else {
        result = ResponseResult.error("MerchantId is Empty");
        isNextRequest = false;
        return result;
      }
    }
    // register customer
    if (user.role.isCustomer && isNextRequest) {
      final customerResponse =
          await _apiClient.auth.addCustomer().awaitResponse;
      customerResponse.whenOrNull(
        data: (data, meta) async {
          final customerId = data.id;
          user = user.copyWith(customerId: customerId);

          if (customerId != 0) {
            final responseCustomer = await _apiClient.auth
                .updateCustomer(customerId, user.toRegisterUserId)
                .awaitResponse;
            responseCustomer.whenOrNull(
              data: (data, meta) => logger.d('Update Customer -> $data'),
              error: (message) {
                result = ResponseResult.error(message);
                isNextRequest = false;
                return result;
              },
            );
          } else {
            result = ResponseResult.error("CustomerId is Empty");
            isNextRequest = false;
            return result;
          }
        },
        error: (message) {
          result = ResponseResult.error(message);
          isNextRequest = false;
        },
      );
    }

    if (isNextRequest) {
      logger.d(user);
      final updatedUserResponse = await _apiClient.auth
          .updateUser(user.id, user.toUpdateMerchantorCustomerId)
          .awaitResponse;
      result = updatedUserResponse;
    }
    return result;
  }

  @override
  Future<ResponseResult<String>> onLogOut() async {
    final user = _sharedPrefsRepository.account?.user;
    if (user == null) return ResponseResult.error('Empty User Id');
    final response = await _apiClient.auth
        .updateUser(user.id, {"notificationToken": null}).awaitResponse;
    final newResponse = response.when(
      data: (data, meta) {
        _sharedPrefsRepository.onLogout();
        return ResponseResult.data('Berhasil Keluar', null);
      },
      error: (message) => ResponseResult<String>.error(message),
    );
    return newResponse;
  }
}
