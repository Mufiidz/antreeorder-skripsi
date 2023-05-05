import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'product_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  static const String id = 'id';
  static const String page = 'page';

  @POST(ConstEndpoints.products)
  Future<ApiResponse<Product>> addProduct(@Body() Product product);

  @PUT(ConstEndpoints.productId)
  Future<ApiResponse<Product>> updateProduct(
      @Path(id) String productId, @Body() Product product);

  @GET(ConstEndpoints.productId)
  Future<ApiResponse<Product>> detailProduct(@Path(id) String productId);

  @DELETE(ConstEndpoints.productId)
  Future<ApiResponse<String>> deleteProduct(@Path(id) String productId);
}
