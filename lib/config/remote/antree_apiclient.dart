import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'antree_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AntreeApiClient {
  factory AntreeApiClient(Dio dio, {String baseUrl}) = _AntreeApiClient;

  static const String antreesPath = '/antrees';
  static const String statusAntreePath = '/statuses';
  static const String ordersPath = '/orders';
  static const String idPath = '/{id}';
  static const String antreeWithIdPath = '$antreesPath$idPath';
  static const String id = 'id';
  static const String isVerify = 'isVerify';
  static const String statusId = 'statusId';
  static const String filterMerchant = 'filters[merchant]';
  static const String filterCustomer = 'filters[customer]';

  @POST(antreesPath)
  Future<BaseResponse<Antree>> createAntree(@Body() BaseBody data);

  @PUT(antreeWithIdPath)
  Future<BaseResponse<Antree>> updateAntree(
      @Path(id) int id, @Body() BaseBody data);

  @GET(antreeWithIdPath)
  Future<BaseResponse<Antree>> getAntree(@Path(id) int id);

  @GET(antreesPath)
  Future<BaseResponse<List<Antree>>> getMerchantAntrees(
      @Query(filterMerchant) int merchantId);

  @GET(antreesPath)
  Future<BaseResponse<List<Antree>>> getCustomerAntrees(@Queries() BaseBody queries);

  @DELETE(antreeWithIdPath)
  Future<BaseResponse<Antree>> deleteAntree(@Path(id) int id);

  @GET(statusAntreePath)
  Future<BaseResponse<List<StatusAntree>>> getStatuses();

  @POST(ordersPath)
  Future<BaseResponse<Order>> createOrder(@Body() BaseBody data);
}
