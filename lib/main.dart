import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/screens/splash_screen.dart';
import 'package:antreeorder/utils/app_route.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
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
          primaryColor: AntreeColors.primaryBlack,
          cardTheme: const CardTheme(color: Colors.white),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              foregroundColor: Colors.white, backgroundColor: Colors.black),
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: AntreeColors.primaryBlack.shade200,
              selectionHandleColor: Colors.black),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: AntreeColors.primaryBlack)
                  .copyWith(background: Colors.white)),
      home: const SplashScreen(),
    );
  }
}
