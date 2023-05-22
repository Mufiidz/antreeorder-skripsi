import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/role.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  List<Role> _roles = [];
  RegisterBloc(this._authRepository) : super(const RegisterState()) {
    on<RegisterEventInitial>((event, emit) async {
      final roles = await _authRepository.getRoles();
      _roles = roles;
      final newRole = _roles.singleWhere(
          (element) => element.name.contain('customer', ignoreCase: true));
      emit(state.copyWith(role: newRole));
    });
    on<RegisterUser>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      logger.d(event.user.toRegister);
      final response = await _authRepository.register(event.user);
      response.when(
          data: (user, meta) {
            emit(state.copyWith(
                status: StatusState.success,
                message: "Berhasil menambahkan ${user.name}"));
          },
          error: (errorMessage) => emit(state.copyWith(
              status: StatusState.failure, message: errorMessage)));
    });
    on<RegisterPasswordVisibility>((event, emit) => emit(state.copyWith(
        isVisiblePassword: event.isVisible, status: StatusState.idle)));
    on<RegisterConsfirmPasswordVisibility>((event, emit) => emit(state.copyWith(
        isVisibleConfirmPassword: event.isVisible, status: StatusState.idle)));
    on<RegisterConvertOption>((event, emit) {
      final role = _roles.singleWhere((element) =>
          element.name.contain(event.type.toLowerCase(), ignoreCase: true));
      emit(state.copyWith(role: role, status: StatusState.idle));
    });
  }
}
