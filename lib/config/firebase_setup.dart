import 'package:antreeorder/service/antree_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';

import 'package:antreeorder/di/injection.dart';

Future<void> setupFirebase() async {
  await getIt<FirebaseMessaging>().requestPermission();
  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your antree notification',
    id: 'antree',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Antree',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  );
  FirebaseMessaging.onMessage.listen(_mappingMessage);
}

Future<void> _mappingMessage(RemoteMessage message) async {
  AntreeNotifications.showNotification(message);
}
