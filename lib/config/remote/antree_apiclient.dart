import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/base_response.dart';
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
  Future<BaseResponse<List<Antree>>> getCustomerAntrees(
      @Query(filterCustomer) int customerId);

  @DELETE(antreeWithIdPath)
  Future<BaseResponse<Antree>> deleteAntree(@Path(id) int id);

  @GET(statusAntreePath)
  Future<BaseResponse<List<StatusAntree>>> getStatuses();

  // VVVV DEPRECATED VVVV

  @POST(ConstEndpoints.antree)
  Future<ApiResponse<Antree>> addAntree(@Body() Antree antree);

  @GET(ConstEndpoints.listAntreeUser)
  Future<ApiResponse<List<Antree>>> listAntree(
      @Path(id) String userId, @CancelRequest() CancelToken cancelToken,
      {@Query('date') int? date});

  @GET(ConstEndpoints.detailAntree)
  Future<ApiResponse<Antree>> detailAntree(@Path(id) String antreeId);

  @PATCH(ConstEndpoints.antreePickup)
  Future<ApiResponse<Antree>> pickupAntree(
      @Path(id) String antreeId, @Query(isVerify) bool isVerify);

  @PATCH(ConstEndpoints.updateAntree)
  Future<ApiResponse<Antree>> updateStatusAntree(
      @Path(id) String antreeId, @Query(statusId) int statusId);
}
