part of 'setting_bloc.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent.initial() = _Initial;
  const factory SettingEvent.logout() = _Logout;
}
