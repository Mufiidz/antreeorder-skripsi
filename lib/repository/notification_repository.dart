import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRepository {
  Future<ResponseResult<Notification>> addNotification(Notification notify);
  Future<ResponseResult<List<Notification>>> getNotifications({int page = 1});
  Future<ResponseResult<List<Notification>>> getUnreadNotifications();
  Future<ResponseResult<Notification>> updateReadNotif(int notificationId);
}

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;

  NotificationRepositoryImpl(this._apiClient, this._sharedPrefsRepository);

  @override
  Future<ResponseResult<Notification>> addNotification(
          Notification notify) async =>
      _apiClient.notification
          .createNotification(notify.toAddNotifOrder.wrapWithData)
          .awaitResponse;

  @override
  Future<ResponseResult<List<Notification>>> getUnreadNotifications() async {
    final id = _sharedPrefsRepository.id;
    if (id == 0) return ResponseResult.error('User Id is Empty');
    final queries = {
      "pagination[pageSize]": 10,
      "filters[to]": id,
      "filters[isReaded][\$eq]": false,
    };
    return _apiClient.notification.getNotifications(queries).awaitResponse;
  }

  @override
  Future<ResponseResult<List<Notification>>> getNotifications(
      {int page = 1}) async {
    final id = _sharedPrefsRepository.id;
    if (id == 0) return ResponseResult.error('User Id is Empty');
    final queries = {
      "pagination[pageSize]": 10,
      'pagination[page]': page,
      "filters[to]": id,
      "populate": '*',
      "sort[0]": "createdAt:desc"
    };
    return _apiClient.notification.getNotifications(queries).awaitResponse;
  }

  @override
  Future<ResponseResult<Notification>> updateReadNotif(
      int notificationId) async {
    BaseBody updatedRead = {
      "isReaded": true,
      "readedAt": DateTime.now().toIso8601String()
    };
    return _apiClient.notification.updateNotification(
        notificationId, updatedRead.wrapWithData, {}).awaitResponse;
  }
}
