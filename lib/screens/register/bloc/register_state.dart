part of 'register_bloc.dart';

class RegisterState extends BaseState<String> {
  final bool isVisiblePassword;
  final bool isVisibleConfirmPassword;
  final bool isUser;
  const RegisterState(super.data,
      {super.status,
      super.message,
      this.isVisiblePassword = true,
      this.isVisibleConfirmPassword = true,
      this.isUser = true});

  @override
  List<Object> get props => [
        data,
        status,
        message,
        isVisiblePassword,
        isUser,
        isVisibleConfirmPassword
      ];

  RegisterState copyWith({
    String? data,
    StatusState? status,
    String? message,
    bool? isVisiblePassword,
    bool? isVisibleConfirmPassword,
    bool? isUser,
  }) {
    return RegisterState(data ?? this.data,
        status: status ?? this.status,
        message: message ?? this.message,
        isVisiblePassword: isVisiblePassword ?? this.isVisiblePassword,
        isVisibleConfirmPassword:
            isVisibleConfirmPassword ?? this.isVisibleConfirmPassword,
        isUser: isUser ?? this.isUser);
  }

  @override
  String toString() =>
      'RegisterState(data: $data, status: $status, isVisiblePassword: $isVisiblePassword, isUser: $isUser, isVisibleConfirmPassword: $isVisibleConfirmPassword, message: $message)';
}
