import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/merchant.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/export_utils.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(ConstEndpoints.merchants)
  Future<ApiResponse<List<Merchant>>> merchants({@Query('page') int page = 1});

  @GET('${ConstEndpoints.merchants}${ConstEndpoints.products}')
  Future<ApiResponse<List<Product>>> merchantProducts(
      @Query('id') String merchantId,
      {@Query('page') int page = 1});

  @POST(ConstEndpoints.antree)
  Future<ApiResponse<Antree>> addAntree(@Body() Antree antree);

  @POST(ConstEndpoints.register)
  Future<ApiResponse<String>> registerUser(@Body() User user);

  @POST(ConstEndpoints.login)
  Future<ApiResponse<User>> loginUser(@Body() User user);

  @GET(ConstEndpoints.detailAntree)
  Future<ApiResponse<Antree>> detailAntree(@Path('id') String antreeId);

  @PATCH(ConstEndpoints.antreePickup)
  Future<ApiResponse<Antree>> pickupAntree(
      @Path('id') String antreeId, @Query('isVerify') bool isVerify);
}
