part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState(
      {@Default(StatusState.idle) StatusState status,
      @Default('') String message,
      @Default(User()) User data,
      @Default(true) bool isVisiblePassword,
      @Default(true) bool isVisibleConfirmPassword,
      @Default(Role()) Role role,
      @Default('') String password}) = _Initial;
}
