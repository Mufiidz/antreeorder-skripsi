import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/splash_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';
import 'section/config_merchant_section.dart';
import 'section/logout_section.dart';
import 'section/merchant_status_section.dart';
import 'section/profile_section.dart';

class SettingMerchantScreen extends StatefulWidget {
  const SettingMerchantScreen({Key? key}) : super(key: key);

  @override
  State<SettingMerchantScreen> createState() => _SettingMerchantScreenState();
}

class _SettingMerchantScreenState extends State<SettingMerchantScreen>
    with WidgetsBindingObserver {
  late final SettingsBloc _settingsBloc;
  late final Merchant? merchant;
  late final AntreeLoadingDialog _loading;
  late final SharedPrefsRepository _sharedPrefsRepository;
  SettingsState state = const SettingsState([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _settingsBloc = getIt<SettingsBloc>();
    _loading = getIt<AntreeLoadingDialog>();
    _sharedPrefsRepository = getIt<SharedPrefsRepository>();
    merchant = _sharedPrefsRepository.account?.merchant;
    _settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settingsBloc,
      child: Scaffold(
        appBar: AntreeAppBar("Settings"),
        body: AntreeState<SettingsBloc, SettingsState>(
          _settingsBloc,
          loadingDialog: _loading,
          onSuccess: (context, state) {
            if (state.isLogout) {
              context.snackbar.showSnackBar(AntreeSnackbar(state.message));
              AppRoute.clearAll(const SplashScreen());
            }
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.success,
            ));
          },
          child: (state, context) {
            this.state = state;
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
        ),
      ),
    );
  }

  List<Widget> get _section => [
        ProfileSection(merchant?.name ?? ''),
        BlocSelector<SettingsBloc, SettingsState, Merchant?>(
          bloc: _settingsBloc,
          selector: (state) => state.merchant,
          builder: (context, state) => MerchantStatusSection(
              value: state?.isOpen ?? _sharedPrefsRepository.isOpen,
              onChanged: (newValue) {
                final merchantId = merchant?.id;
                _sharedPrefsRepository.isOpen = newValue;
                if (merchantId != null && merchantId.isNotEmpty) {
                  _settingsBloc.add(UpdateStatusMerchant(merchantId, newValue));
                }
              }),
        ),
        ConfigMerchantSection(state.data),
        LogoutSection(
          onTapLogout: () {
            _loading.showLoadingDialog(context);
            _settingsBloc.add(LogOut());
          },
        )
      ];
}
