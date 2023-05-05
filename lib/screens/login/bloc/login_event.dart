part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Initial extends LoginEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginUser extends LoginEvent {
  final LoginDto loginDto;

  const LoginUser(this.loginDto);

  @override
  List<Object?> get props => [loginDto];
}

class LoginMerchant extends LoginEvent {
  final LoginDto loginDto;

  const LoginMerchant(this.loginDto);

  @override
  List<Object?> get props => [loginDto];
}

class PassWordVisibility extends LoginEvent {
  final bool isVisible;
  const PassWordVisibility(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class UserSwitch extends LoginEvent {
  final bool isUser;
  const UserSwitch(this.isUser);

  @override
  List<Object?> get props => [isUser];
}
