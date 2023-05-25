import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'merchant_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class MerchantApiClient {
  factory MerchantApiClient(Dio dio, {String baseUrl}) = _MerchantApiClient;

  static const String id = 'id';
  static const String page = 'page';
  static const String isOpen = 'isOpen';
  static const String merchantsPath = '/merchants';
  static const String idPath = '/{id}';
  static const String populate = 'populate';
  static const String merchantWithIdPath = '$merchantsPath$idPath';

  @POST(merchantsPath)
  Future<BaseResponse<Merchant>> createMerchant(@Body() BaseBody data);

  @PUT(merchantWithIdPath)
  Future<BaseResponse<Merchant>> updateMerchant(
      @Path(id) int id, @Body() BaseBody data);

  @GET(merchantWithIdPath)
  Future<BaseResponse<Merchant>> getMerchant(@Path(id) int id,
      {@Query(populate) String query = "*"});

  @GET(merchantsPath)
  Future<BaseResponse<List<Merchant>>> getMerchants(
      {@Query(populate) String populate = 'user',
      @Query('fields[0]') String fields = 'isOpen'});

  @DELETE(merchantWithIdPath)
  Future<BaseResponse<Merchant>> deleteMerchant(@Path(id) int id);
}
