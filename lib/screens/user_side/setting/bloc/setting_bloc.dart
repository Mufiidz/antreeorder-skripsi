import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/content_detail.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SharedPrefsRepository _prefsRepository;
  SettingBloc(this._prefsRepository) : super(const SettingState()) {
    on<SettingEvent>((events, emit) {
      events.map(initial: (event) {
        final account = _prefsRepository.account;
        if (account != null) {
          User user = account.user;
          emit(state.copyWith(user: user, profiles: profiles(user)));
        }
      }, logout: (event) {
        _prefsRepository.onLogout();
        emit(state.copyWith(
            status: StatusState.success, message: 'Berhasil Keluar'));
      });
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
            title: 'Registered At', value: user.createdAt?.toStringDate() ?? '-'),
      ];
}
