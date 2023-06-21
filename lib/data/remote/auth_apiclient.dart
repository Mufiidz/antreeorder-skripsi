
import 'package:antreeorder/data/remote/response/login_response.dart';
import 'package:antreeorder/data/remote/response/role_response.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/customer.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'auth_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  static const String roles = '/users-permissions/roles';
  static const String users = '/users';
  static const String merchants = '/merchants';
  static const String customers = '/customers';
  static const String mePath = '$users/me';
  static const String loginPath = '/auth/local';
  static const String pathId = '/{id}';
  static const String userId = '$users$pathId';
  static const String merchantId = '$merchants$pathId';
  static const String customerId = '$customers$pathId';
  static const String id = 'id';
  static const String populate = 'populate';

  @POST(users)
  Future<User> register(@Body() Map<String, dynamic> register);

  @POST(loginPath)
  Future<LoginResponse> login(@Body() Map<String, String> login);

  @GET(roles)
  Future<RoleResponse> getRoles();

  @GET(mePath)
  Future<User> me();

  @GET(userId)
  Future<User> detailUser(@Path(id) int userId,
      {@Query(populate) String query = "*"});

  @POST(merchants)
  Future<BaseResponse<Merchant>> addMerchant(
      {@Body() Map<String, dynamic> data = const {"data": {}}});

  @POST(customers)
  Future<BaseResponse<Customer>> addCustomer(
      {@Body() Map<String, dynamic> data = const {"data": {}}});

  @PUT(merchantId)
  Future<BaseResponse<Merchant>> updateMerchant(
      @Path(id) int merchantId, @Body() Map<String, dynamic> mapUserDetail);

  @PUT(customerId)
  Future<BaseResponse<Customer>> updateCustomer(
      @Path(id) int customerId, @Body() Map<String, dynamic> mapUserDetail);

  @PUT(userId)
  Future<User> updateUser(
      @Path(id) int userId, @Body() Map<String, dynamic> user);
}
