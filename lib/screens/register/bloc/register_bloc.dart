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
    on<RegisterEvent>((events, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final resultState = await events.when(
        initial: _initial,
        passwordVisibility: (isVisible) async => state.copyWith(
            isVisiblePassword: isVisible, status: StatusState.idle),
        confrimPasswordVisibility: (isVisible) async => state.copyWith(
            isVisibleConfirmPassword: isVisible, status: StatusState.idle),
        registerUser: _registerUser,
        getRole: _getRole,
        onPasswordChange: (password) async {
          RegisterState newState = state.copyWith(status: StatusState.idle);
          if (password == null) return newState;
          return newState.copyWith(password: password);
        },
      );
      emit(resultState);
    });
  }

  Future<RegisterState> _initial() async {
    final roles = await _authRepository.getRoles();
    _roles = roles;
    final newRole = _roles.singleWhere(
        (element) => element.name.contain('customer', ignoreCase: true),
        orElse: () => Role(
            id: 1,
            name: 'Customer',
            description: 'Default role given to authenticated user.'));
    return state.copyWith(role: newRole, status: StatusState.idle);
  }

  Future<RegisterState> _registerUser(User user) async {
    logger.d(user.toRegister);
    final response = await _authRepository.register(user);
    return response.when(
        data: (user, meta) => state.copyWith(
            status: StatusState.success,
            message: "Berhasil menambahkan ${user.name}"),
        error: (errorMessage) =>
            state.copyWith(status: StatusState.failure, message: errorMessage));
  }

  Future<RegisterState> _getRole(String type) async {
    final role = _roles.singleWhere((element) =>
        element.name.contain(type.toLowerCase(), ignoreCase: true));
    return state.copyWith(role: role, status: StatusState.idle);
  }
}
