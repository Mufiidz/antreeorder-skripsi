import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:intl/intl.dart';

abstract class AntreeRepository {
  Future<ResponseResult<Antree>> addAntree(Antree antree, Merchant merchant);
  Future<ResponseResult<Antree>> detailAntree(int antreeId);
  Future<ResponseResult<List<Antree>>> getMerchantAntrees({BaseBody? query});
  Future<ResponseResult<List<Antree>>> getCustomerAntrees();
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree();
}

@inject.Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final AntreeDatabase _antreeDatabase;
  final NotificationRepository _notificationRepository;

  AntreeRepositoryImpl(this._apiClient, this._sharedPrefsRepository,
      this._antreeDatabase, this._notificationRepository);

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
  Future<ResponseResult<Antree>> detailAntree(int antreeId) async {
    if (antreeId == 0) return ResponseResult.error('Empty Antree Id');
    final queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };
    return _apiClient.antree.getAntree(antreeId, queries).awaitResponse;
  }

  @override
  Future<ResponseResult<Antree>> addAntree(
      Antree antree, Merchant merchant) async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    final List<Order> orders = antree.orders;
    // validation
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    if (merchant.id == 0) return ResponseResult.error('Merchant Id is empty');
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
    final nomorAntree = await _getNomorAntree(merchant.id);
    final remaining = nomorAntree != null ? (nomorAntree - 1) : null;
    final BaseBody mapAntree = {
      "totalPrice": antree.totalPrice,
      "merchant": merchant.id,
      "customer": customerId,
      "seat": antree.seat.id,
      "orders": orderIds,
      "nomorAntree": nomorAntree,
      "remaining": remaining,
      "status": 1
    };
    logger.d(mapAntree);

    final response = await _apiClient.antree
        .createAntree(mapAntree.wrapWithData)
        .awaitResponse;

    // add notification
    final user = _sharedPrefsRepository.user;

    var notification = response.when(
      data: (data, meta) => Notification(
          title: "Ada Pesanan baru nih",
          message: "Pesanan dari customer nih cek yuk buat dikonfirmasi",
          type: NotificationType.antree,
          contentId: data.id,
          from: user,
          to: merchant.user),
      error: (message) => null,
    );

    if (notification == null) return response;

    await _notificationRepository.addNotification(notification).awaitResponse;
    return response;
  }

  Future<int?> _getNomorAntree(int merchantId) async {
    logger.d("Getting nomor antree");
    final date = DateTime.now();
    final String now = DateFormat("yyyy-MM-dd").format(date);
    final String tomorrow =
        DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
    final Map<String, dynamic> nomorAntreeQuery = {
      'filters[merchant]': merchantId,
      'pagination[pageSize]': 10,
      'filters[createdAt][\$gte]': now,
      'filters[createdAt][\$lt]': tomorrow
    };
    final response = await _apiClient.antree
        .getMerchantAntrees(nomorAntreeQuery)
        .awaitResponse;
    int? nomorAntree = response.whenOrNull(
      data: (data, meta) => meta!.pagination.total,
    );
    nomorAntree = nomorAntree != null ? (nomorAntree + 1) : nomorAntree;
    return nomorAntree;
  }
}
