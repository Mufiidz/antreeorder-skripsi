import 'package:antreeorder/config/remote/response/login_response.dart';
import 'package:antreeorder/config/remote/response/role_response.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/customer.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'auth_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  static const String _local = '/auth/local';
  static const String _roles = '/users-permissions/roles';
  static const String _users = '/users';
  static const String _merchants = '/merchants';
  static const String _customers = '/customers';
  static const String _me = '$_users/me';
  static const String _login = _local;
  static const String _pathId = '/{id}';
  static const String _userId = '$_users$_pathId';
  static const String _merchantId = '$_merchants$_pathId';
  static const String _customerId = '$_customers$_pathId';

  static const String _id = 'id';
  static const String _populate = 'populate';

  @POST(_users)
  Future<User> register(@Body() Map<String, dynamic> register);

  @POST(_login)
  Future<LoginResponse> login(@Body() Map<String, String> login);

  @GET(_roles)
  Future<RoleResponse> getRoles();

  @GET(_me)
  Future<User> me();

  @GET(_userId)
  Future<User> detailUser(@Path(_id) int userId,
      {@Query(_populate) String query = "*"});

  @POST(_merchants)
  Future<BaseResponse<Merchant>> addMerchant(
      {@Body() Map<String, dynamic> data = const {"data": {}}});

  @POST(_customers)
  Future<BaseResponse<Customer>> addCustomer(
      {@Body() Map<String, dynamic> data = const {"data": {}}});

  @PUT(_merchantId)
  Future<BaseResponse<Merchant>> updateMerchant(
      @Path(_id) int merchantId, @Body() Map<String, dynamic> mapUserDetail);

  @PUT(_customerId)
  Future<BaseResponse<Customer>> updateCustomer(
      @Path(_id) int customerId, @Body() Map<String, dynamic> mapUserDetail);

  @PUT(_userId)
  Future<User> updateUser(@Path(_id) int userId, @Body() Map<String, dynamic> user);
}
