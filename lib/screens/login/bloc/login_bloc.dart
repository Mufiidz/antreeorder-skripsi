import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/role.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginState()) {
    on<LoginEvent>((event, emit) {
      event.whenOrNull(
        passwordVisibility: (isVisible) => emit(state.copyWith(
            isVisiblePassword: isVisible, status: StatusState.idle)),
      );
    });
    on<LoginUser>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response = await _authRepository.login(event.user);
      response.whenOrNull(
        data: (user, meta) {
          emit(state.copyWith(
              status: StatusState.success,
              data: user,
              isUser: user.role.isCustomer,
              message: "Selamat Datang ${user.name}"));
        },
        error: (message) =>
            emit(state.copyWith(status: StatusState.failure, message: message)),
      );
    });
  }
}
