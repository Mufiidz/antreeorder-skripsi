import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'DB_FILENAME')
  static const String dbFileName = _Env.dbFileName;

  @EnviedField(varName: 'NOTIF_TOKEN')
  static const String firebaseNotifToken = _Env.firebaseNotifToken;

  @EnviedField(varName: 'MIDTRAINS_SANDBOX_BASE_URL')
  static const String midtrainsBaseUrl = _Env.midtrainsBaseUrl;

  @EnviedField(varName: 'AUTH_SERVER', obfuscate: true)
  static String authServerMidtrains = _Env.authServerMidtrains;

  @EnviedField(varName: 'MESSAGING_SENDER_ID')
  static String firebaseSenderId = _Env.firebaseSenderId;

  @EnviedField(obfuscate: true)
  static String FIREBASE_APIKEY_ANDROID = _Env.FIREBASE_APIKEY_ANDROID;

  @EnviedField(varName: 'FIREBASE_APPID_ANDROID')
  static const String firebaseAppIdAndroid = _Env.firebaseAppIdAndroid;

  @EnviedField(varName: 'FIREBASE_APIKEY_IOS', obfuscate: true)
  static String firebaseApikeyIos = _Env.firebaseApikeyIos;

  @EnviedField(varName: 'FIREBASE_APPID_IOS')
  static const String firebaseAppIdIos = _Env.firebaseAppIdIos;

  @EnviedField(varName: 'FIREBASE_CLIENTID_IOS')
  static const String firebaseClientIdIos = _Env.firebaseClientIdIos;
}
