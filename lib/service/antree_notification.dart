import 'dart:convert';

import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AntreeNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void init() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveNotificationResponse);
  }

  static void showNotification(RemoteMessage message) async {
    final notification = message.notification ?? RemoteNotification();
    final data = message.data;
    return await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          data['type'] as String? ?? '',
          data['type'] as String? ?? '',
        )),
        payload: jsonEncode(data));
  }

  static void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload == null || payload.isEmpty) return;
    final notification =
        Notification.fromFirebaseMessaging(jsonDecode(payload));

    final isMerchant =
        getIt<SharedPrefsRepository>().account?.isMerchant ?? false;

    if (notification.type == NotificationType.antree) {
      if (isMerchant) {
        AppRoute.to(DetailAntreeScreen(antreeId: notification.contentId));
      } else {
        AppRoute.to(AntreeScreen(notification.contentId));
      }
    }
  }
}
