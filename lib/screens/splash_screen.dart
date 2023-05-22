import 'dart:async';

import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/home/home_screen.dart';
import 'package:antreeorder/screens/user_side/home/home_screen.dart'
    as userside;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/export_components.dart';
import '../res/export_res.dart';
import '../utils/export_utils.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AntreeText(
            "AntreeOrder",
            style: AntreeTextStyle.title,
            textColor: Colors.white,
          ),
        ));
  }

  void _initialize() async {
    final account = getIt<SharedPrefsRepository>().account;
    logger.d(account);
    Timer(const Duration(seconds: 3), () {
      if (account == null) {
        AppRoute.clearTopTo(const LoginScreen());
      } else {
        AppRoute.clearTopTo(account.isMerchant
            ? const HomeScreen()
            : const userside.HomeScreen());
      }
    });
  }
}
