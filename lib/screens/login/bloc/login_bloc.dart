import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/models/login_dto.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final SharedPrefsRepository _sharedPrefRepo;
  LoginBloc(this._authRepository, this._sharedPrefRepo)
      : super(const LoginState(User())) {
    on<Initial>(
        (event, emit) => emit(state.copyWith(isUser: _sharedPrefRepo.isUser)));
    on<LoginUser>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _authRepository.loginUser(event.loginDto);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                data: data,
                status: StatusState.success,
                message: "Welcome back ${data.name}")
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });

    on<LoginMerchant>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _authRepository.loginMerchant(event.loginDto);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                merchant: data,
                status: StatusState.success,
                message: "Welcome back ${data.name}")
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });

    on<PassWordVisibility>((event, emit) => emit(state.copyWith(
        isVisiblePassword: event.isVisible, status: StatusState.idle)));

    on<UserSwitch>((event, emit) {
      _sharedPrefRepo.isUser = event.isUser;
      emit(state.copyWith(isUser: event.isUser, status: StatusState.idle));
    });
  }
}
