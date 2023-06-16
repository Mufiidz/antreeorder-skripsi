part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.unreadNotification() = _UnreadNotification;
  const factory HomeEvent.updateNotificationToken(String refreshedToken) = _UpdateNotificationToken;
  const factory HomeEvent.antreesPagination(int page) = _AntreesPagination;
}