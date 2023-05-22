import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/order.dart' as order;
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'merchant_repository.dart';
import 'product_repository.dart';

abstract class AntreeRepository {
  Future<ApiResponse<Antree>> add(Antree antree);
  Future<ApiResponse<Antree>> detail(String antreeId);
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify);
  Future<ApiResponse<List<Antree>>> listAntree(String userId);
  Future<ApiResponse<Antree>> updateStatusAntree(String antreeId, int statusId);
  void cancelRequest({String? reason});
}

@Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;
  final ProductRepository _productRepository;
  final MerchantRepository _merchantRepository;
  final CancelToken _cancelToken;

  @factoryMethod
  AntreeRepositoryImpl(this._apiClient, this._cancelToken,
      this._productRepository, this._merchantRepository);

  @override
  Future<ApiResponse<Antree>> add(Antree antree) =>
      _apiClient.antree.addAntree(antree).awaitResult;

  @override
  Future<ApiResponse<Antree>> detail(String antreeId) =>
      _apiClient.antree.detailAntree(antreeId).awaitResult;

  @override
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify) =>
      _apiClient.antree.pickupAntree(antreeId, isVerify);

  @override
  Future<ApiResponse<Antree>> updateStatusAntree(
          String antreeId, int statusId) =>
      _apiClient.antree.updateStatusAntree(antreeId, statusId).awaitResult;

  @override
  Future<ApiResponse<List<Antree>>> listAntree(String userId) async {
    var response = await _apiClient.antree
        .listAntree(userId, _cancelToken, date: 5)
        .awaitResult;
    List<Antree> data = response.data ?? [];
    if (response.code == 200 && data.isNotEmpty) {
      for (var antree in data) {
        List<order.Order> newOrders = [];
        final merchantResponse = await _merchantRepository
            .detailMerchant(antree.merchantId.toString());

        for (var order in antree.orders) {
          final productResponse = await _productRepository
              .detailProduct(order.productId.toString());
          order = order.copyWith(product: productResponse.data);
          newOrders.add(order);
        }
        data = data
            .map((antree) => antree.copyWith(
                merchant: merchantResponse.data ?? antree.merchant,
                orders: newOrders))
            .toList();
        logger.d(data);
        response = response.copyWith(data: data);
      }
    }
    return response;
  }

  @override
  void cancelRequest({String? reason}) => _cancelToken.cancel(reason);
}
