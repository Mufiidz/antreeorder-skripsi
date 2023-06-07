import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/image.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

abstract class ProductRepository {
  Future<ResponseResult<Product>> addProduct(Product product, XFile? file);
  Future<ResponseResult<Product>> updateProduct(Product product, XFile? file);
  Future<ResponseResult<Product>> detailProduct(int productId);
  Future<ResponseResult<List<Product>>> deleteProduct(Product product);
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
  Future<ResponseResult<Product>> addProduct(
      Product product, XFile? file) async {
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    var response = await _apiClient.product
        .createProduct(product.toAddProduct(merchantId).wrapWithData)
        .awaitResponse;
    response = await response.when(
      data: (data, meta) async {
        if (file == null) return response;
        final imageResponse = await _uploudImage(
            data.copyWith(merchant: Merchant(id: merchantId)), file);
        return imageResponse.when(
            data: (imageData, imageMeta) => ResponseResult.data(
                data.copyWith(cover: imageData.first), meta),
            error: (message) => ResponseResult.error(message));
      },
      error: (message) => response,
    );
    return response;
  }

  @override
  Future<ResponseResult<List<Product>>> deleteProduct(Product product) async {
    final productId = product.id;
    final imageId = product.cover?.id ?? 0;
    if (productId == 0) return ResponseResult.error('Product Id is empty');
    final deleteResponse =
        await _apiClient.product.deleteProduct(productId).awaitResponse;
    if (imageId != 0) {
      await _apiClient.product.deleteImage(imageId);
    }
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
  Future<ResponseResult<Product>> updateProduct(
      Product product, XFile? file) async {
    final imageId = product.cover?.id;
    if (product.id == 0) return ResponseResult.error('Product Id is empty');
    if (file != null) await _uploudImage(product, file);
    if (imageId != null && imageId != 0)
      await _apiClient.product.deleteImage(imageId);
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
    final queries = {
      "filters[merchant]": merchantId,
      "populate": '*',
      'pagination[page]': page,
      'pagination[pageSize]': size,
    };
    return await _apiClient.product.getMerchantProducts(queries).awaitResponse;
  }

  Future<ResponseResult<List<Image>>> _uploudImage(
      Product product, XFile image) async {
    String imgPath = image.path;
    final ext = path.extension(imgPath);
    final now = DateTime.now();
    final merchantId = product.merchant.id;
    if (merchantId == 0) return ResponseResult.error("Empty Merchant Id");
    final imageFile = await MultipartFile.fromFile(imgPath,
        filename:
            'Product${product.id}${product.merchant.id}${now.toStringDate(pattern: 'ddMMyyHHmm')}$ext',
        contentType: MediaType('image', ext.replaceFirst('.', '')));
    final mapUploudImg = <String, dynamic>{
      "files": imageFile,
      "ref": 'api::product.product',
      "refId": product.id,
      "field": "cover"
    };
    final form = FormData.fromMap(mapUploudImg);
    return _apiClient.product.uploudImage(form).awaitResponse;
  }
}
