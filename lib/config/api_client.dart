import 'package:dio/dio.dart';

import 'package:antreeorder/data/remote/antree_apiclient.dart';
import 'package:antreeorder/data/remote/auth_apiclient.dart';
import 'package:antreeorder/data/remote/firebase_notif_apiclient.dart';
import 'package:antreeorder/data/remote/merchant_apiclient.dart';
import 'package:antreeorder/data/remote/notification_apiclient.dart';
import 'package:antreeorder/data/remote/payment_apiclient.dart';
import 'package:antreeorder/data/remote/product_apiclient.dart';
import 'package:antreeorder/data/remote/seat_apiclient.dart';

import 'env.dart';

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
