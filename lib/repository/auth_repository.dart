import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/local/role_dao.dart';
import 'package:antreeorder/config/remote/response/login_response.dart';
import 'package:antreeorder/models/account.dart';
import 'package:antreeorder/models/role.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<ResponseResult<User>> register(User user);
  Future<ResponseResult<User>> login(User user);
  Future<List<Role>> getRoles();
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
    if (roles.isEmpty) {
      final response = await _apiClient.auth.getRoles();
      for (var element in response.roles) {
        _roleDao.addRole(element);
      }
      roles = response.roles;
    }
    return roles;
  }

  @override
  Future<ResponseResult<User>> login(User user) async {
    ResponseResult<User> result = const ResponseResult.error('EMPTY');
    _dio.options.headers = {"Authorization": ""};
    final response = await _apiClient.auth.login(user.toLogin).awaitResponse;
    Account account = Account();
    int userId = 0;

    if (response is ResponseResultData<LoginResponse>) {
      final data = response.data;
      _dio.options.headers = {"Authorization": "Bearer ${data.jwt}"};
      userId = data.user.id;

      account = account.copyWith(token: data.jwt);
      result = ResponseResult.data(data.user, response.meta);
    }

    if (response is ResponseResultError<LoginResponse>) {
      return ResponseResult.error(response.message);
    }

    final responseMe = await _apiClient.auth.detailUser(userId).awaitResponse;

    responseMe.when(
      data: (data, meta) {
        account = account.copyWith(isMerchant: data.role.isMerchant, user: data);
        result = responseMe;
      },
      error: (message) {
        return ResponseResult.error(message);
      },
    );

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
    return result;
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
}
