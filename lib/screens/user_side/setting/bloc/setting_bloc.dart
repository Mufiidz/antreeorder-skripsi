import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/datetime_ext.dart';

part 'setting_bloc.freezed.dart';
part 'setting_event.dart';
part 'setting_state.dart';

@singleton
@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SharedPrefsRepository _prefsRepository;
  final AuthRepository _authRepository;
  SettingBloc(this._prefsRepository, this._authRepository)
      : super(const SettingState()) {
    on<SettingEvent>((events, emit) async {
      final newState = await events.when(
        initial: () async {
          final account = _prefsRepository.account;
          if (account == null) {
            return state.copyWith(
                status: StatusState.failure,
                message: 'Account not initialized');
          }
          User user = account.user;
          return state.copyWith(user: user, profiles: profiles(user));
        },
        logout: () async {
          final response = await _authRepository.onLogOut();
          final newState = response.when(
            data: (data, meta) =>
                state.copyWith(status: StatusState.success, message: data),
            error: (message) =>
                state.copyWith(status: StatusState.failure, message: message),
          );
          return newState;
        },
      );
      emit(newState);
    });
  }

  List<ContentDetail> profiles(User user) => [
        ContentDetail(title: 'User ID', value: '${user.username}${user.id}'),
        ContentDetail(
            title: 'Username',
            value: user.username.isNotEmpty ? user.username : '-'),
        ContentDetail(
            title: 'Name', value: user.name.isNotEmpty ? user.name : '-'),
        ContentDetail(
            title: 'Registered At',
            value: user.createdAt?.toStringDate() ?? '-'),
      ];
}
