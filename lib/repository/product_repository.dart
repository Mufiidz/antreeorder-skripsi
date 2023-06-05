import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class ProductRepository {
  Future<ResponseResult<Product>> addProduct(Product product);
  Future<ResponseResult<Product>> updateProduct(Product product);
  Future<ResponseResult<Product>> detailProduct(int productId);
  Future<ResponseResult<List<Product>>> deleteProduct(int productId);
  Future<ResponseResult<List<Product>>> getMerchantProducts(
      {int merchantId, int page, int size});
}

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;

  @factoryMethod
  ProductRepositoryImpl(this._apiClient, this._sharedPrefsRepository);

  @override
  Future<ResponseResult<Product>> addProduct(Product product) async {
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    return _apiClient.product
        .createProduct(product.toAddProduct(merchantId).wrapWithData)
        .awaitResponse;
  }

  @override
  Future<ResponseResult<List<Product>>> deleteProduct(int productId) async {
    if (productId == 0) return ResponseResult.error('Product Id is empty');
    final deleteResponse =
        await _apiClient.product.deleteProduct(productId).awaitResponse;
    if (deleteResponse is ResponseResultError<Product>) {
      return ResponseResult.error(deleteResponse.message);
    }
    return getMerchantProducts();
  }

  @override
  Future<ResponseResult<Product>> detailProduct(int productId) async {
    if (productId == 0) return ResponseResult.error('Product Id is empty');
    return await _apiClient.product.getProduct(productId).awaitResponse;
  }

  @override
  Future<ResponseResult<Product>> updateProduct(Product product) async {
    if (product.id == 0) return ResponseResult.error('Product Id is empty');
    return await _apiClient.product
        .updateProduct(product.id, product.toUpdateProduct.wrapWithData)
        .awaitResponse;
  }

  @override
  Future<ResponseResult<List<Product>>> getMerchantProducts(
      {int? merchantId, int page = 1, int size = 10}) async {
    final int currentMerchantId = _sharedPrefsRepository.user.merchantId;
    merchantId = merchantId ?? currentMerchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    return await _apiClient.product
        .getMerchantProducts(merchantId, page: page)
        .awaitResponse;
  }
}
