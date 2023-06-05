import 'package:antreeorder/config/api_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  const Notification._();
  factory Notification({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String message,
    @Default(false) bool isReaded,
    User? from,
    User? to,
    @Default(0) int contentId,
    @NotificationTypeConverter()
    @Default(NotificationType.nothing)
    NotificationType type,
    DateTime? readedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  BaseBody get toAddNotifOrder {
    return {
      "title": title,
      "message": message,
      "from": from?.id,
      "to": to?.id,
      "type": type.name,
      "contentId": contentId,
      "isReaded": false
    };
  }
}

enum NotificationType { antree, merchant, consumer, user, product, nothing }

class NotificationTypeConverter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeConverter();

  @override
  String toJson(NotificationType object) => object.name;

  @override
  NotificationType fromJson(String json) {
    NotificationType resultType = NotificationType.nothing;
    try {
      resultType = NotificationType.values.byName(json);
    } catch (e) {
      resultType = resultType;
    }
    return resultType;
  }
}
