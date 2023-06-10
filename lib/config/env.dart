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
}
