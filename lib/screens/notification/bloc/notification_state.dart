part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState(
      {@Default(StatusState.idle) StatusState status,
      @Default([]) List<Notification> notifications,
      @Default('') String message,
      @Default(Page()) Page page,
      @Default(true) bool isLastPage}) = _NotificationState;
}
