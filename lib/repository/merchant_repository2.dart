import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/order.dart' as order;
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext2.dart';
import 'package:injectable/injectable.dart';

abstract class MerchantRepository2 {
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1});
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
      {int page = 1});
  Stream<ApiResponse<List<Product>>> streamAntrianMerchant(String merchantId);
  // Future<ApiResponse<List<Antree>>> antrianMerchant(String merchantId,{int? date});
  Future<ApiResponse<Merchant>> detailMerchant(String merchantId);
  Future<ApiResponse<Merchant>> updateStatusMerchant(
      String merchantId, bool isOpen);
  // Future<ApiResponse<String>> addCategory(
  //     String merchantId, List<String> categories);
  // Future<ApiResponse<List<String>>> getMerchantCategories(String merchantId);
  Future<ApiResponse<Seat>> addSeat(Seat seat);
  Future<ApiResponse<List<Seat>>> getMerchantSeat(String merchantId);
}

@Injectable(as: MerchantRepository2)
class MerchantRepositoryImpl2 extends MerchantRepository2 {
  final ApiClient _apiClient;
  final ProductRepository _productRepository;

  @factoryMethod
  MerchantRepositoryImpl2(this._apiClient, this._productRepository);

  @override
  Future<ApiResponse<List<Merchant>>> getMerchants({int page = 1}) =>
      _apiClient.merchant.merchants(page: page).awaitResult;

  @override
  Future<ApiResponse<List<Product>>> getMerchantProduct(String merchantId,
          {int page = 1}) =>
      _apiClient.merchant.merchantProducts(merchantId, page: page);

  // @override
  // Future<ApiResponse<List<Antree>>> antrianMerchant(String merchantId,
  //     {int? date}) async {
  // var response = await _apiClient.merchant
  //     .antrianMerchant(merchantId, date: date)
  //     .awaitResult;
  // List<Antree> data = response.data ?? [];
  // if (response.code == 200 && data.isNotEmpty) {
  //   for (var antree in data) {
  //     List<order.Order> newOrders = [];
  //     for (var order in antree.orders) {
  //       final productResponse =
  //           await _productRepository.detailProduct(order.productId);
  //       order = order.copyWith(
  //           product: (productResponse as ResponseResultData).data);
  //       newOrders.add(order);
  //     }
  //     data =
  //         data.map((antree) => antree.copyWith(orders: newOrders)).toList();
  //     response = response.copyWith(data: data);
  //   }
  // }
  // return response;
  // }

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
  Stream<ApiResponse<List<Product>>> streamAntrianMerchant(
      String merchantId) async* {
    final test = Stream.periodic(const Duration(seconds: 30),
        (count) => _apiClient.merchant.streamAntrianMerchant(merchantId));
  }

  @override
  Future<ApiResponse<Merchant>> updateStatusMerchant(
          String merchantId, bool isOpen) =>
      _apiClient.merchant.updateStatusMerchant(merchantId, isOpen).awaitResult;
}
