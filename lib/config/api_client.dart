import 'package:dio/dio.dart';

import 'env.dart';
import 'remote/antree_apiclient.dart';
import 'remote/auth_apiclient.dart';
import 'remote/firebase_notif_apiclient.dart';
import 'remote/merchant_apiclient.dart';
import 'remote/notification_apiclient.dart';
import 'remote/payment_apiclient.dart';
import 'remote/product_apiclient.dart';
import 'remote/seat_apiclient.dart';

typedef BaseBody = Map<String, dynamic>;

class ApiClient {
  final Dio dio;
  static const String baseUrl = Env.baseUrl;
  static const String midtransBaseUrl = Env.midtrainsBaseUrl;

  ApiClient(this.dio);

  AuthApiClient get auth => AuthApiClient(dio, baseUrl: baseUrl);

  MerchantApiClient get merchant => MerchantApiClient(dio, baseUrl: baseUrl);

  ProductApiClient get product => ProductApiClient(dio, baseUrl: baseUrl);

  AntreeApiClient get antree => AntreeApiClient(dio, baseUrl: baseUrl);

  SeatApiClient get seat => SeatApiClient(dio, baseUrl: baseUrl);

  NotificationApiClient get notification =>
      NotificationApiClient(dio, baseUrl: baseUrl);

  FirebaseNotifApiClient get firebaseNotification =>
      FirebaseNotifApiClient(dio);

  PaymentApiClient payment({String url = midtransBaseUrl}) =>
      PaymentApiClient(dio, baseUrl: url);
}
