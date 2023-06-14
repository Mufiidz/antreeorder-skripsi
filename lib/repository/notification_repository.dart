import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRepository {
  Future<ResponseResult<Notification>> addNotification(Notification notify);
  Future<ResponseResult<List<Notification>>> getNotifications({int page = 1});
  Future<ResponseResult<List<Notification>>> getUnreadNotifications();
  Future<ResponseResult<Notification>> updateReadNotif(int notificationId);
  Future<ResponseResult<User>> getNotificationToken();
  Future<ResponseResult<User>> updateTokenNotification(String newToken);
}

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final FirebaseMessaging _firebaseMessaging;

  NotificationRepositoryImpl(
      this._apiClient, this._sharedPrefsRepository, this._firebaseMessaging);

  @override
  Future<ResponseResult<Notification>> addNotification(
      Notification notify) async {
    final receiverNotifToken = notify.to?.notificationToken;
    final response = await _apiClient.notification
        .createNotification(notify.toAddNotifOrder.wrapWithData)
        .awaitResponse;
    if (receiverNotifToken == null || receiverNotifToken.isEmpty)
      return response;
    if (response is ResponseResultData<Notification>) {
      await _apiClient.firebaseNotification
          .pushNotification(response.data.pushNotification(receiverNotifToken))
          .awaitResponse;
    }
    return response;
  }

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

  @override
  Future<ResponseResult<User>> getNotificationToken() async {
    User user = _sharedPrefsRepository.user;
    final userNotifToken = user.notificationToken;
    if (user.id == 0) return ResponseResult.error('UserId is empty');
    var notificationToken =
        await _firebaseMessaging.getToken().then((value) => value) ?? '';
    _firebaseMessaging.onTokenRefresh.listen((event) {
      logger.d(event);
      logger.d(notificationToken);
      notificationToken = event;
    });
    if (notificationToken.isEmpty) {
      return ResponseResult.data(user, null);
    }
    if (userNotifToken != null && userNotifToken.contain(notificationToken)) {
      return ResponseResult.data(user, null);
    }
    user = user.copyWith(notificationToken: notificationToken);
    final response = await _apiClient.auth
        .updateUser(user.id, user.updateNotificationToken)
        .awaitResponse;
    var account = _sharedPrefsRepository.account;
    if (response is ResponseResultData<User>) {
      account = account?.copyWith(user: response.data);
      _sharedPrefsRepository.account = account;
    }
    return response;
  }

  @override
  Future<ResponseResult<User>> updateTokenNotification(String newToken) async {
    logger.i('Notif Token Updated => $newToken');
    User user = _sharedPrefsRepository.user;
    if (user.id == 0) return ResponseResult.error('User Id is Empty');
    BaseBody mapToken = {'notificationToken': newToken};
    return _apiClient.auth
        .updateUser(user.id, mapToken)
        .awaitResponse;
  }
}
