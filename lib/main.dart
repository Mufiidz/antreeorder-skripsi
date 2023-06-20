import 'package:antreeorder/config/firebase_setup.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/screens/splash_screen.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/service/antree_notification.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupDI();
  AntreeNotifications.init();
  await setupFirebase();
  runApp(const MyApp());
  // runApp(DevicePreview(
  //   enabled: kDebugMode,
  //   tools: [
  //     ...DevicePreview.defaultTools,
  //     DevicePreviewScreenshot(
  //       multipleScreenshots: true,
  //       onScreenshot: screenshotAsFiles(Directory.current),
  //     )
  //   ],
  //   builder: (BuildContext context) => const MyApp(),
  // ));
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
