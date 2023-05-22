import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/merchant_side/settings/section/logout_section.dart';
import 'package:antreeorder/screens/merchant_side/settings/section/profile_section.dart';
import 'package:antreeorder/screens/splash_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/setting_bloc.dart';
import 'detail_profile_section.dart';

class SettingUserScreen extends StatefulWidget {
  const SettingUserScreen({Key? key}) : super(key: key);

  @override
  State<SettingUserScreen> createState() => _SettingUserScreenState();
}

class _SettingUserScreenState extends State<SettingUserScreen> {
  late final SettingBloc _settingBloc;
  late final AntreeLoadingDialog _loadingDialog;
  SettingState _state = const SettingState();

  @override
  void initState() {
    super.initState();
    _loadingDialog = getIt<AntreeLoadingDialog>();
    _settingBloc = getIt<SettingBloc>();
    _settingBloc.add(const SettingEvent.initial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settingBloc,
      child: Scaffold(
        appBar: AntreeAppBar('Settings'),
        body: BlocConsumer<SettingBloc, SettingState>(
            bloc: _settingBloc,
            builder: (context, state) {
              _state = state;
              return AntreeList(
                _section,
                isSeparated: true,
                itemBuilder: (context, section, index) => section,
                separatorBuilder: (context, section, index) => const Divider(
                  height: 30,
                  thickness: 5,
                  color: AntreeColors.separator,
                ),
              );
            },
            listener: (context, state) {
              if (state.status == StatusState.success) {
                _loadingDialog.dismiss();
                context.snackbar.showSnackBar(AntreeSnackbar(state.message));
                AppRoute.clearAll(const SplashScreen());
              }
            }),
      ),
    );
  }

  List<Widget> get _section => [
        ProfileSection(_state.user.name),
        DetailProfileSection(profiles: _state.profiles),
        LogoutSection(
          onTapLogout: () {
            _loadingDialog.showLoadingDialog(context);
            _settingBloc.add(const SettingEvent.logout());
          },
        )
      ];
}
