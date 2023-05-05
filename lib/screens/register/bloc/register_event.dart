part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUser extends RegisterEvent {
  final User user;

  const RegisterUser(this.user);

  @override
  List<Object?> get props => [user];
}

class RegisterMerchant extends RegisterEvent {
  final Merchant merchant;

  const RegisterMerchant(this.merchant);

  @override
  List<Object?> get props => [merchant];
}

class PassWordVisibility extends RegisterEvent {
  final bool isVisible;
  const PassWordVisibility(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class ConfirmPassWordVisibility extends RegisterEvent {
  final bool isVisible;
  const ConfirmPassWordVisibility(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class ConvertUser extends RegisterEvent {
  final String userValue;
  const ConvertUser(this.userValue);

  @override
  List<Object?> get props => [userValue];
}
