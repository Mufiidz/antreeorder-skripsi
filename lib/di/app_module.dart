import 'package:antreeorder/components/antree_loading_dialog.dart';
import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/local/category_dao.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/export_utils.dart';

@module
@injectable
abstract class AppModule {
  @singleton
  Dio dio(SharedPrefsRepository sharedPrefsRepository) {
    final Dio dio = Dio(BaseOptions(
      baseUrl: Const.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, DELETE, POST, PATCH, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, Authorization",
      },
    ))
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    final account = sharedPrefsRepository.account;
    if (account != null) {
      final token =
          account.isMerchant ? account.merchant?.token : account.user?.token;
      if (token != null && token.isNotEmpty) {
        dio.options.headers = {"Authorization": "Bearer $token"};
      }
    }
    return dio;
  }

  @lazySingleton
  @factoryMethod
  ApiClient apiClient(Dio dio) => ApiClient(dio);

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  AntreeDatabase antreeDatabase() => AntreeDatabase();

  @lazySingleton
  @factoryMethod
  CategoryDao categoryDao(AntreeDatabase antreeDatabase) =>
      CategoryDao(antreeDatabase);

  @singleton
  AntreeLoadingDialog antreeDialog() => AntreeLoadingDialog();

  @singleton
  CancelToken cancelToken() => CancelToken();
}
