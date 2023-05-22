import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/utils/retrofit_ext2.dart';
import 'package:injectable/injectable.dart';

abstract class ProductRepository {
  Future<ApiResponse<Product>> addProduct(Product product);
  Future<ApiResponse<Product>> updateProduct(Product product);
  Future<ApiResponse<Product>> detailProduct(String productId);
  Future<ApiResponse<String>> deleteProduct(String productId);
}

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ApiClient _apiClient;

  ProductRepositoryImpl(@factoryMethod this._apiClient);

  @override
  Future<ApiResponse<Product>> addProduct(Product product) =>
      _apiClient.product.addProduct(product).awaitResult;

  @override
  Future<ApiResponse<String>> deleteProduct(String productId) =>
      _apiClient.product.deleteProduct(productId).awaitResult;

  @override
  Future<ApiResponse<Product>> detailProduct(String productId) =>
      _apiClient.product.detailProduct(productId).awaitResult;

  @override
  Future<ApiResponse<Product>> updateProduct(Product product) =>
      _apiClient.product.updateProduct(product.id.toString(), product).awaitResult;
}
