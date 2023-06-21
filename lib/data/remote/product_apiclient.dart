import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/image.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'product_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  static const String productsPath = '/products';
  static const String uploud = '/upload';
  static const String files = '/files';
  static const String idPath = '/{id}';
  static const String productWithIdPath = '$productsPath$idPath';
  static const String deleteImagePath = '$uploud$files$idPath';
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
      @Queries() BaseBody queries);

  @DELETE(productWithIdPath)
  Future<BaseResponse<Product>> deleteProduct(@Path(id) int id);

  @POST(uploud)
  Future<List<Image>> uploudImage(@Body() FormData data,
      {@Header('Content-Type') String contentType = 'multipart/form-data'});

  @DELETE(deleteImagePath)
  Future<Image> deleteImage(@Path(id) int imageId);
}
