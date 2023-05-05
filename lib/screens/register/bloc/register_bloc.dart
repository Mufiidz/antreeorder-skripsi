import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  RegisterBloc(this._authRepository) : super(const RegisterState('')) {
    on<RegisterUser>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _authRepository.registerUser(event.user);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                data: data, status: StatusState.success, message: data)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });

    on<RegisterMerchant>((event, emit) async {
      try {
        final response = await _authRepository.registerMerchant(event.merchant);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                data: data, status: StatusState.success, message: data)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });

    on<PassWordVisibility>((event, emit) => emit(state.copyWith(
        isVisiblePassword: event.isVisible, status: StatusState.idle)));

    on<ConfirmPassWordVisibility>((event, emit) => emit(state.copyWith(
        isVisibleConfirmPassword: event.isVisible, status: StatusState.idle)));

    on<ConvertUser>((event, emit) {
      final isUser = event.userValue.contain("user", ignoreCase: true);
      emit(state.copyWith(isUser: isUser, status: StatusState.idle));
    });
  }
}
