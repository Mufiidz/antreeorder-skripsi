part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.getNotifications({@Default(1) int page}) =
      _GetNotifications;
  const factory NotificationEvent.readNotifications(Notification notification) =
      _ReadNotifications;
}
