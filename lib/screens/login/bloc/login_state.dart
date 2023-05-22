part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  @Implements<BaseState2<User>>()
  factory LoginState({
    @Default(StatusState.idle) StatusState status,
    @Default('') String message,
    @Default(User()) User data,
    @Default(true) bool isUser,
    @Default(true) bool isVisiblePassword
  }) = _Initial;
}
