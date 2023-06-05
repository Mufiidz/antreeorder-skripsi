import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/notification_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract class StatusAntreeRepository {
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree);
  // Future<ResponseResult<Antree>> confirmAntree(Antree antree);
  Future<ResponseResult<Antree>> takeOrder(Antree antree);
}

@Injectable(as: StatusAntreeRepository)
class StatusAntreeRepositoryImpl implements StatusAntreeRepository {
  final ApiClient _apiClient;
  final AntreeRepository _antreeRepository;
  final SharedPrefsRepository _sharedPrefsRepository;
  final NotificationRepository _notificationRepository;

  StatusAntreeRepositoryImpl(this._apiClient, this._antreeRepository,
      this._sharedPrefsRepository, this._notificationRepository);

  @override
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree) async {
    if (antree.id == 0) return ResponseResult.error('Antree Id is empty');
    if (antree.status.id == 0)
      return ResponseResult.error('Status Id is empty');
    final statusId = antree.status.id;
    final mapUpdateStatus = antree.toUpdateStatus;
    if (statusId == 3) {
      logger.d('statusId($statusId) -> decrease remaining on');
      mapUpdateStatus['remaining'] = 0;
    }
    if (statusId >= 4 && statusId <= 7) {
      logger.d('decrease remaining on');
      decreasingRemaining();
    }

    // add notification
    final response =
        await updateAntree(antree.id, mapUpdateStatus.wrapWithData);

    return _addNotification(response);
  }

  // @override
  // Future<ResponseResult<Antree>> confirmAntree(Antree antree) async {
  //   logger.d('Confirm -> ${antree.id}');
  //   if (antree.id == 0) return ResponseResult.error('Antree Id is empty');
  //   if (antree.status.id == 0)
  //     return ResponseResult.error('Status Id is empty');
  //   final status = antree.status;
  //   antree = antree.copyWith(status: status.copyWith(id: (status.id + 1)));
  //   final nomorAntree = await getNomorAntree();
  //   var remaining = nomorAntree != null ? (nomorAntree - 1) : null;

  //   final Map<String, dynamic> mapConfrimAntree = antree.toUpdateStatus;
  //   if (nomorAntree != null) mapConfrimAntree["nomorAntree"] = nomorAntree;
  //   if (remaining != null) {
  //     remaining = remaining < 0 ? 0 : remaining;
  //     mapConfrimAntree["remaining"] = remaining;
  //   }
  //   logger.d(mapConfrimAntree);
  //   final response =
  //       await updateAntree(antree.id, mapConfrimAntree.wrapWithData);
  //   return _addNotification(response);
  // }

  Future<ResponseResult<Antree>> updateAntree(
      int antreeId, BaseBody updatedBody) {
    BaseBody queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };

    return _apiClient.antree
        .updateAntree(antreeId, updatedBody, queries)
        .awaitResponse;
  }

  // Future<int?> getNomorAntree() async {
  //   final merchantId = _sharedPrefsRepository.account?.user.merchantId;
  //   if (merchantId == null) return null;
  //   final date = DateTime.now();
  //   final String now = DateFormat("yyyy-MM-dd").format(date);
  //   final String tomorrow =
  //       DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
  //   final Map<String, dynamic> nomorAntreeQuery = {
  //     'filters[merchant]': merchantId,
  //     'pagination[pageSize]': 10,
  //     'filters[createdAt][\$gte]': now,
  //     'filters[createdAt][\$lt]': tomorrow
  //   };
  //   final response =
  //       await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
  //   int? nomorAntree = response.whenOrNull(
  //     data: (data, meta) => meta?.pagination.total,
  //     error: (message) => null,
  //   );
  //   return nomorAntree != null ? (nomorAntree + 1) : null;
  // }

  void decreasingRemaining() async {
    final merchantId = _sharedPrefsRepository.account?.user.merchantId;
    if (merchantId == null) return null;
    final date = DateTime.now();
    final String now = DateFormat("yyyy-MM-dd").format(date);
    final String tomorrow =
        DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
    final Map<String, dynamic> nomorAntreeQuery = {
      'filters[merchant]': merchantId,
      'filters[isVerify]': false,
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
      'filters[status][id][\$eq]': 2,
      'filters[createdAt][\$gte]': now,
      'filters[createdAt][\$lt]': tomorrow,
    };
    final response =
        await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
    response.whenOrNull(
      data: (data, meta) async {
        data.forEach((element) async {
          logger.d(
              'decrease -> ${element.id} | remaining -> ${element.remaining}');
          final remaining = element.remaining;
          if (remaining != null || remaining != 0) {
            BaseBody decreaseRemaining = {"remaining": (remaining! - 1)};
            logger.d('updating remaining w other antree');
            await updateAntree(element.id, decreaseRemaining.wrapWithData);
          }
        });
      },
    );
  }

  @override
  Future<ResponseResult<Antree>> takeOrder(Antree antree) async {
    final takenAt = DateTime.now();
    BaseBody queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };

    final response = await _apiClient.antree
        .updateAntree(
            antree.id, antree.toTakeOrder(takenAt).wrapWithData, queries)
        .awaitResponse;

    return _addNotification(response,
        from: antree.merchant.user, to: antree.customer.user);
  }

  ResponseResult<Antree> _addNotification(ResponseResult<Antree> response,
      {User? from, User? to}) {
    final newFrom = from ?? _sharedPrefsRepository.user;
    final notification = response.when(
      data: (data, meta) {
        final newTo = to ?? data.customer.user;
        var notification = Notification(
            from: newFrom,
            to: newTo,
            type: NotificationType.antree,
            contentId: data.id);
        if (data.status.id == 2)
          return notification.copyWith(
              title: 'Pesanan Terkonfirmasi',
              message:
                  'Pesanan telah terkonfirmasi nih, kamu lagi dalam antrean tunggu ya..');
        // if (data.remaining == 0 || data.status.id == 3)
        //   return notification.copyWith(
        //       title: 'Pesanan Diproses',
        //       message: 'Pesanan lagi diproses nih tunggu sebentar lagi');
        if (data.status.id == 4)
          return notification.copyWith(
              title: 'Pesanan Siap Diambil',
              message: 'Pesananmu sudah jadi nih, ambil pesananmu di toko yaa');
        if (data.status.id == 6 || data.isVerify && data.takenAt != null)
          return notification.copyWith(
              title: 'Pesanan Sudah diambil',
              message: 'Terima kasih sudah memesan yaa...');
        if (data.status.id == 7)
          return notification.copyWith(
              title: 'Pesanan Dibatalkan',
              message: 'Yah, pesananmu dibatalkan');
        return null;
      },
      error: (message) => null,
    );
    if (notification != null) {
      _notificationRepository.addNotification(notification);
    }
    return response;
  }

  // Future<int?> getRemaining(Antree antree) async {
  //   final date = DateTime.now();
  //   final String now = DateFormat("yyyy-MM-dd").format(date);
  //   final String tomorrow =
  //       DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
  //   final Map<String, dynamic> nomorAntreeQuery = {
  //     'filters[merchant]': antree.merchant.id,
  //     'pagination[pageSize]': 10,
  //     'filters[createdAt][\$gte]': now,
  //     'filters[createdAt][\$lt]': tomorrow,
  //     'fliters[isVerify][\$eq]': false
  //   };
  //   final response =
  //       await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
  //   return 0;
  // }
}
