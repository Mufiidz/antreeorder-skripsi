part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getAllData() = _GetAllData;
  const factory HomeEvent.upadateStatusAntree(Antree antree, bool isConfirm) =
      _UpadateStatusAntree;
  const factory HomeEvent.updateNotificationToken(String refreshedToken) =
      _UpdateNotificationToken;
  const factory HomeEvent.antreesPagination(int newPage) = _AntreesPagination;
}
