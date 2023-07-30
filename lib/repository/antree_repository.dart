import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/env.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/midtrans_payment.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/online_payment.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/repository/payment_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:intl/intl.dart';

abstract class AntreeRepository {
  Future<ResponseResult<Antree>> addAntree(Antree antree, Merchant merchant);
  Future<ResponseResult<Antree>> addOnlinePayment(
      Antree antree, Merchant merchant);
  Future<ResponseResult<Antree>> addAntreeOnlinePayment(int antreeId);
  Future<ResponseResult<Antree>> detailAntree(int antreeId);
  Future<ResponseResult<List<Antree>>> getMerchantAntrees(
      {int page = 1, BaseBody? query});
  Future<ResponseResult<List<Antree>>> getCustomerAntrees({int page = 1});
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree();
}

@inject.Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final AntreeDatabase _antreeDatabase;
  final NotificationRepository _notificationRepository;
  final PaymentRepository _paymentRepository;

  AntreeRepositoryImpl(
    this._apiClient,
    this._sharedPrefsRepository,
    this._antreeDatabase,
    this._notificationRepository,
    this._paymentRepository,
  );

  @override
  Future<ResponseResult<List<Antree>>> getCustomerAntrees(
      {int page = 1}) async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    final BaseBody queries = {
      'filters[customer]': customerId,
      'populate[merchant][populate][0]': 'user',
      'filters[isVerify][\$eq]': false,
      'populate[orders]': '*',
      'populate[status]': '*',
      'populate[payment]': '*',
      'pagination[pageSize]': 10,
      'pagination[page]': page,
      'sort[0]': 'nomorAntree',
      'sort[1]': 'createdAt:desc'
    };
    var response =
        await _apiClient.antree.getCustomerAntrees(queries).awaitResponse;
    // Checking payment
    response = await response.when(
      data: (data, meta) => checkingPayment(data, meta),
      error: (message) => response,
    );
    return response;
  }

  @override
  Future<ResponseResult<List<Antree>>> getMerchantAntrees(
      {int page = 1, BaseBody? query}) async {
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    final BaseBody queries = query ??
        {
          'filters[merchant]': merchantId,
          'populate[customer][populate][0]': 'user',
          'filters[isVerify][\$eq]': false,
          'populate[orders]': '*',
          'populate[status]': '*',
          'populate[payment]': '*',
          'pagination[pageSize]': 10,
          'pagination[page]': page,
          'filters[status][id][\$gte]': 1,
          'filters[status][id][\$lt]': 6,
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
  Future<ResponseResult<Antree>> addOnlinePayment(
      Antree antree, Merchant merchant) async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    final List<Order> orders = antree.orders;
    // validation
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    if (merchant.id == 0) return ResponseResult.error('Merchant Id is empty');
    if (orders.isEmpty) return ResponseResult.error('Orders is empty');
    if (antree.seat.id == 0) return ResponseResult.error('Seat is empty');

    ResponseResult<Order> result = ResponseResult.error("Init");
    // add antree
    final BaseBody mapAddAntree = {
      "totalPrice": antree.totalPrice,
      "merchant": merchant.id,
      "customer": customerId,
      "seat": antree.seat.id,
      "status": 8,
    };
    final antreeResponse = await _apiClient.antree
        .createAntree(mapAddAntree.wrapWithData)
        .awaitResponse;
    final antreeId = antreeResponse.when(
      data: (data, meta) => data.id,
      error: (message) => 0,
    );

    if (antreeId == 0) return ResponseResult.error('Antree Id is empty');

    // Get token payment
    final items = orders.map((order) => order.toItemMidtrans).toList();
    final midtransPayment = MidtransPayment(
        transactionDetails: TransactionDetails(
            orderId: antreeId.toString(), grossAmount: antree.totalPrice),
        itemDetails: items);
    final tokenPaymentResponse = await _apiClient
        .payment()
        .tokenPayment(midtransPayment.toJson(),
            authorization: 'Basic ${Env.authServerMidtrains}')
        .awaitResponse;
    final payment = tokenPaymentResponse.whenOrNull(
      data: (data, meta) => OnlinePayment(
          token: data.token,
          redirectUrl: data.redirectUrl,
          paymentId: antreeId.toString()),
    );
    if (payment == null) return ResponseResult.error('Direct Payment is Empty');
    // post payment
    final paymentResponse = await _apiClient
        .payment(url: ApiClient.baseUrl)
        .addPayment(payment.toAddPayment.wrapWithData)
        .awaitResponse;
    final paymentId = paymentResponse.when(
      data: (data, meta) => data.id,
      error: (message) => 0,
    );
    if (paymentId == 0) return ResponseResult.error('PaymentId is Empty');

    // post order
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

    final BaseBody mapAntree = {"orders": orderIds, "payment": paymentId};
    return _apiClient.antree.updateAntree(
        antreeId, mapAntree.wrapWithData, {'populate': '*'}).awaitResponse;
  }

  @override
  Future<ResponseResult<Antree>> addAntreeOnlinePayment(int antreeId) async {
    if (antreeId == 0) return ResponseResult.error('Antree Id is empty');
    final antreeResponse = await _apiClient.antree
        .getAntree(antreeId, {'populate': '*'}).awaitResponse;
    final antree = antreeResponse.whenOrNull(
      data: (data, meta) => data,
    );
    if (antree == null) return ResponseResult.error('Antree is Empty');
    if (antree.merchant.id == 0)
      return ResponseResult.error('Merchant Id is Empty');
    var nomorAntree = await _getNomorAntree(antree.merchant.id);
    nomorAntree = nomorAntree != null ? (nomorAntree - 1) : null;
    final remaining = nomorAntree != null ? (nomorAntree - 1) : null;
    final BaseBody mapAntree = {
      "nomorAntree": nomorAntree,
      "remaining": remaining,
      "status": 1
    };
    final BaseBody queries = {
      'populate[merchant][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };
    final response = await _apiClient.antree
        .updateAntree(antreeId, mapAntree.wrapWithData, queries)
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
          to: data.merchant.user),
      error: (message) => null,
    );

    if (notification == null) return response;

    await _notificationRepository.addNotification(notification).awaitResponse;
    return response;
  }

  @override
  Future<ResponseResult<Antree>> addAntree(
      Antree antree, Merchant merchant) async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    final List<Order> orders = antree.orders;
    final bool isMerchant = _sharedPrefsRepository.account?.isMerchant ?? false;
    // validation
    if (!isMerchant) {
      if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    }
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
    BaseBody mapAntree = {
      "totalPrice": antree.totalPrice,
      "merchant": merchant.id,
      "seat": antree.seat.id,
      "orders": orderIds,
      "nomorAntree": nomorAntree,
      "remaining": remaining,
      "status": 1
    };
    if (!isMerchant) {
      mapAntree["customer"] = customerId;
    }
    logger.d(mapAntree);

    final response = await _apiClient.antree
        .createAntree(mapAntree.wrapWithData)
        .awaitResponse;

    // dont send notif if from merchant
    if (isMerchant) return response;

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

  Future<ResponseResult<List<Antree>>> checkingPayment(
      List<Antree> data, Meta? meta) async {
    var newData = <Antree>[];
    for (var antree in data) {
      final paymentId = antree.payment?.paymentId ?? '';
      final statusId = antree.status.id;

      if (statusId != 8 || paymentId.isEmpty) {
        newData.add(antree);
        continue;
      }

      final response = await _paymentRepository.paymentStatus(paymentId);
      antree = response.when(
        data: (data, meta) {
          if (data.toPaymentStatusState().id != 11) return antree;
          var newAntree = antree.copyWith(status: data.toPaymentStatusState());
          _paymentRepository.expirePayment(newAntree);
          return newAntree;
        },
        error: (message) => antree,
      );
      newData.add(antree);
    }
    return ResponseResult.data(newData, meta);
  }
}
