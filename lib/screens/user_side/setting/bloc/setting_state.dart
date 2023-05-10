part of 'setting_bloc.dart';

@freezed
class SettingState with _$SettingState {
  const factory SettingState({
    @Default(User()) User user,
    @Default(StatusState.idle) StatusState status,
    @Default('') String message,
    @Default([]) List<ContentDetail> profiles,
  }) = _SettingState;
}
