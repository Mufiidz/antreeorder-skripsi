part of 'login_bloc.dart';

class LoginState extends BaseState<User> {
  final bool isVisiblePassword;
  final bool isUser;
  final Merchant merchant;
  const LoginState(super.data,
      {super.status,
      super.message,
      this.isVisiblePassword = true,
      this.isUser = true,
      this.merchant = const Merchant()});

  @override
  List<Object> get props =>
      [data, status, message, isVisiblePassword, isUser, merchant];

  LoginState copyWith({
    User? data,
    StatusState? status,
    String? message,
    bool? isVisiblePassword,
    bool? isUser,
    Merchant? merchant,
  }) {
    return LoginState(data ?? this.data,
        status: status ?? this.status,
        message: message ?? this.message,
        isVisiblePassword: isVisiblePassword ?? this.isVisiblePassword,
        isUser: isUser ?? this.isUser,
        merchant: merchant ?? this.merchant);
  }

  @override
  String toString() =>
      'LoginState(data: $data, status: $status, message: $message, isVisiblePassword: $isVisiblePassword, isUser: $isUser, merchant: $merchant)';
}
