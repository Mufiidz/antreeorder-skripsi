import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'merchant_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class MerchantApiClient {
  factory MerchantApiClient(Dio dio, {String baseUrl}) = _MerchantApiClient;

  static const String id = 'id';
  static const String page = 'page';
  static const String isOpen = 'isOpen';

  @GET(ConstEndpoints.merchants)
  Future<ApiResponse<List<Merchant>>> merchants({@Query(page) int page = 1});

  @GET(ConstEndpoints.merchantProducts)
  Future<ApiResponse<List<Product>>> merchantProducts(
      @Path(id) String merchantId,
      {@Query(page) int page = 1});

  @GET(ConstEndpoints.antrianMerchants)
  Future<ApiResponse<List<Antree>>> antrianMerchant(@Path(id) String merchantId,
      {@Query('date') int? date});

  @GET(ConstEndpoints.antrianMerchants)
  Stream<ApiResponse<List<Antree>>> streamAntrianMerchant(
      @Path(id) String merchantId);

  @GET(ConstEndpoints.detailMerchant)
  Future<ApiResponse<Merchant>> detailMerchant(@Path(id) String merchantId);

  @PATCH(ConstEndpoints.detailMerchant)
  Future<ApiResponse<Merchant>> updateStatusMerchant(
      @Path(id) String merchantId, @Query(isOpen) bool isOpen);

  // @POST(ConstEndpoints.merchantCategory)
  // Future<ApiResponse<String>> addCategory(
  //     @Path(id) String merchantId, @Body() List<String> categories);

  // @GET(ConstEndpoints.merchantCategory)
  // Future<ApiResponse<List<String>>> getCategories(@Path(id) String merchantId);

  @POST(ConstEndpoints.seats)
  Future<ApiResponse<Seat>> addSeat(@Body() Seat seat);

  @GET(ConstEndpoints.merchantSeats)
  Future<ApiResponse<List<Seat>>> getMerchantSeats(@Path(id) String merchantId);
}
