part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
   const factory LoginEvent.initial() = LoginEventInitial;
  const factory LoginEvent.passwordVisibility(bool isVisible) = LoginPasswordVisibility;
  const factory LoginEvent.loginUser(User user) = LoginUser;
}