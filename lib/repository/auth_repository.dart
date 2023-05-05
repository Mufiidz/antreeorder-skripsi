import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/login_dto.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/models/account.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<ApiResponse<String>> registerUser(User user);
  Future<ApiResponse<String>> registerMerchant(Merchant merchant);
  Future<ApiResponse<User>> loginUser(LoginDto loginDto);
  Future<ApiResponse<Merchant>> loginMerchant(LoginDto loginDto);
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final Dio _dio;

  @factoryMethod
  AuthRepositoryImpl(this._apiClient, this._sharedPrefsRepository, this._dio);

  @override
  Future<ApiResponse<Merchant>> loginMerchant(LoginDto loginDto) async {
    final response = await _apiClient.auth.loginMerchant(loginDto).awaitResult;
    final data = response.data;
    if (data != null) {
      final account = Account(isMerchant: true, merchant: data);
      _sharedPrefsRepository.account = account;
      _dio.options.headers = {"Authorization": "Bearer ${data.token}"};
    }
    return response;
  }

  @override
  Future<ApiResponse<User>> loginUser(LoginDto loginDto) async {
    final response = await _apiClient.auth.loginUser(loginDto).awaitResult;
    final data = response.data;
    if (data != null) {
      final account = Account(isMerchant: false, user: data);
      _sharedPrefsRepository.account = account;
      _dio.options.headers = {"Authorization": "Bearer ${data.token}"};
    }
    return response;
  }

  @override
  Future<ApiResponse<String>> registerMerchant(Merchant merchant) =>
      _apiClient.auth.registerMerchant(merchant).awaitResult;

  @override
  Future<ApiResponse<String>> registerUser(User user) =>
      _apiClient.auth.registerUser(user).awaitResult;
}
