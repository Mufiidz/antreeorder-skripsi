import 'package:antreeorder/config/api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/export_utils.dart';

@module
@injectable
abstract class AppModule {
  @singleton
  Dio dio() => Dio(BaseOptions(
        baseUrl: Const.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          "Access-Control-Allow-Credentials": true,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, DELETE, POST, PATCH, OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type, Authorization"
        },
      ))
        ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ));

  @lazySingleton
  @factoryMethod
  ApiClient apiClient(Dio dio) => ApiClient(dio);

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
