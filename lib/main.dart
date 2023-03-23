import 'package:antreeorder/screens/splash_screen.dart';
import 'package:antreeorder/utils/app_route.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AntreeOrder',
      navigatorKey: AppRoute.navigatorKey,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: AntreeColors.primaryBlack,
          textSelectionTheme:
              TextSelectionThemeData(
                selectionColor: AntreeColors.primaryBlack.shade200,
                selectionHandleColor: Colors.black
                )),
      home: const SplashScreen(),
    );
  }
}
