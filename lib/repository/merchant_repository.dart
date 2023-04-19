import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

import '../models/product.dart';

abstract class MerchantRepository {
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1});
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
      {int page = 1});
}

@Injectable(as: MerchantRepository)
class MerchantRepositoryImpl extends MerchantRepository {
  final ApiClient _apiClient;

  MerchantRepositoryImpl(@factoryMethod this._apiClient);

  @override
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1}) =>
      _apiClient.merchants(page: page).awaitResult;

  @override
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
          {int page = 1}) =>
      _apiClient.merchantProducts(merchantId, page: page);
}
