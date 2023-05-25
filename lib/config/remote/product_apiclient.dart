import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'product_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  static const String productsPath = '/products';
  static const String idPath = '/{id}';
  static const String productWithIdPath = '$productsPath$idPath';
  static const String id = 'id';

  @POST(productsPath)
  Future<BaseResponse<Product>> createProduct(@Body() BaseBody data);

  @PUT(productWithIdPath)
  Future<BaseResponse<Product>> updateProduct(
      @Path(id) int id, @Body() BaseBody data);

  @GET(productWithIdPath)
  Future<BaseResponse<Product>> getProduct(@Path(id) int id);

  @GET(productsPath)
  Future<BaseResponse<List<Product>>> getProducts();

  @GET(productsPath)
  Future<BaseResponse<List<Product>>> getMerchantProducts(
    @Query('filters[merchant]') int merchantId, {
    @Query('pagination[page]') int page = 1,
    @Query('pagination[pageSize]') int size = 10,
  });

  @DELETE(productWithIdPath)
  Future<BaseResponse<Product>> deleteProduct(@Path(id) int id);
}
