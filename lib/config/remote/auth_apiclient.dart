import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/login_dto.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'auth_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST(ConstEndpoints.userRegister)
  Future<ApiResponse<String>> registerUser(@Body() User user);

  @POST(ConstEndpoints.userLogin)
  Future<ApiResponse<User>> loginUser(@Body() LoginDto loginDto);

  @POST(ConstEndpoints.merchantRegister)
  Future<ApiResponse<String>> registerMerchant(@Body() Merchant merchant);

  @POST(ConstEndpoints.merchantLogin)
  Future<ApiResponse<Merchant>> loginMerchant(@Body() LoginDto loginDto);
}
