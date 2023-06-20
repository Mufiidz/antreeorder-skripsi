part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.initial() = _RegisterEventInitial;
  const factory RegisterEvent.passwordVisibility(bool isVisible) = _RegisterPasswordVisibility;
  const factory RegisterEvent.confrimPasswordVisibility(bool isVisible) = _RegisterConsfirmPasswordVisibility;
  const factory RegisterEvent.registerUser(User user) = _RegisterUser;
  const factory RegisterEvent.getRole(String type) = _RegisterConvertOption;
  const factory RegisterEvent.onPasswordChange(String? password) = _OnPasswordChange;
}