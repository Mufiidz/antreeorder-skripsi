import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart' as inject;

abstract class AntreeRepository {
  Future<ResponseResult<Antree>> addAntree(Antree antree, int merchantId);
  Future<ResponseResult<List<Antree>>> getMerchantAntrees({BaseBody? query});
  Future<ResponseResult<List<Antree>>> getCustomerAntrees();
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree();
}

@inject.Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final AntreeDatabase _antreeDatabase;

  AntreeRepositoryImpl(
      this._apiClient, this._sharedPrefsRepository, this._antreeDatabase);

  @override
  Future<ResponseResult<List<Antree>>> getCustomerAntrees() async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    // send notif here
    final BaseBody queries = {
      'filters[customer]': customerId,
      'populate[merchant][populate][0]': 'user',
      'filters[isVerify][\$eq]': false,
      'populate[orders]': '*',
      'populate[status]': '*',
      'pagination[pageSize]': 10,
    };
    return _apiClient.antree.getCustomerAntrees(queries).awaitResponse;
  }

  @override
  Future<ResponseResult<List<Antree>>> getMerchantAntrees(
      {BaseBody? query}) async {
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    final BaseBody queries = query ??
        {
          'filters[merchant]': merchantId,
          'populate[customer][populate][0]': 'user',
          'filters[isVerify][\$eq]': false,
          'populate[orders]': '*',
          'populate[status]': '*',
          'pagination[pageSize]': 10,
          'sort[0]': 'nomorAntree',
          'sort[1]': 'createdAt:desc',
        };
    return await _apiClient.antree.getMerchantAntrees(queries).awaitResponse;
  }

  @override
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree() async {
    List<StatusAntree> statusAntree =
        await _antreeDatabase.statusAntreeDao.statusesAntree();
    if (statusAntree.isNotEmpty) return ResponseResult.data(statusAntree, null);
    ResponseResult<List<StatusAntree>> response =
        await _apiClient.antree.getStatuses().awaitResponse;
    response = response.when(
      data: (data, meta) {
        data.forEach((element) =>
            _antreeDatabase.statusAntreeDao.addStatusAntree(element));
        return ResponseResult.data(data, meta);
      },
      error: (message) => ResponseResult.error(message),
    );
    return response;
  }

  @override
  Future<ResponseResult<Antree>> addAntree(
      Antree antree, int merchantId) async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    final List<Order> orders = antree.orders;
    // validation
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    if (orders.isEmpty) return ResponseResult.error('Orders is empty');
    if (antree.seat.id == 0) return ResponseResult.error('Seat is empty');

    // post order
    ResponseResult<Order> result = ResponseResult.error("Init");
    List<int> orderIds = [];
    for (var order in orders) {
      result = await _apiClient.antree
          .createOrder(order.toAddOrder.wrapWithData)
          .awaitResponse;
      if (result is ResponseResultData<Order>) {
        orderIds.add(result.data.id);
      }
      if (result is ResponseResultError<Order>) break;
    }
    if (result is ResponseResultError<Order>)
      return ResponseResult.error(result.message);

    // post antree
    final BaseBody mapAntree = {
      "totalPrice": antree.totalPrice,
      "merchant": merchantId,
      "customer": customerId,
      "seat": antree.seat.id,
      "orders": orderIds,
      "status": 1
    };
    logger.d(mapAntree.wrapWithData);
    return await _apiClient.antree
        .createAntree(mapAntree.wrapWithData)
        .awaitResponse;
  }
}
