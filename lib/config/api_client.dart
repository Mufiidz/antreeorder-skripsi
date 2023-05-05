import 'package:dio/dio.dart';

import 'remote/antree_apiclient.dart';
import 'remote/auth_apiclient.dart';
import 'remote/merchant_apiclient.dart';
import 'remote/product_apiclient.dart';

class ApiClient {
  final Dio dio;
  static const String baseUrl = 'http://10.0.2.2:8080/antree-order';

  ApiClient(this.dio);

  AuthApiClient get auth => AuthApiClient(dio, baseUrl: baseUrl);

  MerchantApiClient get merchant => MerchantApiClient(dio, baseUrl: baseUrl);

  ProductApiClient get product => ProductApiClient(dio, baseUrl: baseUrl);

  AntreeApiClient get antree => AntreeApiClient(dio, baseUrl: baseUrl);
}
