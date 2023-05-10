import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'antree_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AntreeApiClient {
  factory AntreeApiClient(Dio dio, {String baseUrl}) = _AntreeApiClient;

  static const String id = 'id';
  static const String isVerify = 'isVerify';
  static const String statusId = 'statusId';

  // Antree
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
