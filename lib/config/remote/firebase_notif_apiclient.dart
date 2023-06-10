import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/env.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/firebase_notif.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'firebase_notif_apiclient.g.dart';

@RestApi(baseUrl: 'https://fcm.googleapis.com')
abstract class FirebaseNotifApiClient {
  factory FirebaseNotifApiClient(Dio dio, {String baseUrl}) =
      _FirebaseNotifApiClient;

  static const String notifPath = '/fcm/send';
  static const String authorization = 'Authorization';

  @POST(notifPath)
  Future<FirebaseNotif> pushNotification(
    @Body() BaseBody body, {
    @Header(authorization)
    String bearerToken = 'Bearer ${Env.firebaseNotifToken}',
  });
}
