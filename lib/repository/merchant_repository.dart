import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

import '../models/product.dart';

abstract class MerchantRepository {
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1});
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
      {int page = 1});
  Stream<ApiResponse<List<Product>>> streamAntrianMerchant(String merchantId);
  Future<ApiResponse<List<Antree>>> antrianMerchant(String merchantId);
  Future<ApiResponse<Merchant>> detailMerchant(String merchantId);
  // Future<ApiResponse<String>> addCategory(
  //     String merchantId, List<String> categories);
  // Future<ApiResponse<List<String>>> getMerchantCategories(String merchantId);
  Future<ApiResponse<Seat>> addSeat(Seat seat);
  Future<ApiResponse<List<Seat>>> getMerchantSeat(String merchantId);
}

@Injectable(as: MerchantRepository)
class MerchantRepositoryImpl extends MerchantRepository {
  final ApiClient _apiClient;

  MerchantRepositoryImpl(@factoryMethod this._apiClient);

  @override
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1}) =>
      _apiClient.merchant.merchants(page: page).awaitResult;

  @override
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
          {int page = 1}) =>
      _apiClient.merchant.merchantProducts(merchantId, page: page);

  @override
  Future<ApiResponse<List<Antree>>> antrianMerchant(String merchantId) =>
      _apiClient.merchant.antrianMerchant(merchantId).awaitResult;

  @override
  Future<ApiResponse<Merchant>> detailMerchant(String merchantId) =>
      _apiClient.merchant.detailMerchant(merchantId).awaitResult;

  // @override
  // Future<ApiResponse<String>> addCategory(
  //         String merchantId, List<String> categories) =>
  //     _apiClient.merchant.addCategory(merchantId, categories).awaitResult;

  @override
  Future<ApiResponse<Seat>> addSeat(Seat seat) =>
      _apiClient.merchant.addSeat(seat).awaitResult;

  // @override
  // Future<ApiResponse<List<String>>> getMerchantCategories(String merchantId) =>
  //     _apiClient.merchant.getCategories(merchantId).awaitResult;

  @override
  Future<ApiResponse<List<Seat>>> getMerchantSeat(String merchantId) =>
      _apiClient.merchant.getMerchantSeats(merchantId).awaitResult;

  @override
  Stream<ApiResponse<List<Product>>> streamAntrianMerchant(String merchantId) async* {
    final test = Stream.periodic(const Duration(seconds: 30),
          (count) => _apiClient.merchant.streamAntrianMerchant(merchantId));
  }
      
}
