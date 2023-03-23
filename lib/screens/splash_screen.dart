import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/export_components.dart';
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
    return const Scaffold(
        body: Center(
      child: AntreeText(
        "AntreeOrder",
        textType: AntreeTextType.title,
      ),
    ));
  }

  void _initialize() async {
    // var sharedPreferences = await SharedPreferences.getInstance();
    // var isLogin = sharedPreferences.getBool(SharedPref.isLogin) ?? false;
    Timer(const Duration(seconds: 3), () {
      AppRoute.clearTopTo(const LoginScreen());
    });
  }
}
