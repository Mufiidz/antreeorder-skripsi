part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.initial() = RegisterEventInitial;
  const factory RegisterEvent.passwordVisibility(bool isVisible) = RegisterPasswordVisibility;
  const factory RegisterEvent.confrimPasswordVisibility(bool isVisible) = RegisterConsfirmPasswordVisibility;
  const factory RegisterEvent.registerUser(User user) = RegisterUser;
  const factory RegisterEvent.getRole(String type) = RegisterConvertOption;
}