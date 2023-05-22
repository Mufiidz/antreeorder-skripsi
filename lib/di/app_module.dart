import 'package:antreeorder/components/antree_loading_dialog.dart';
import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/local/category_dao.dart';
import 'package:antreeorder/config/local/role_dao.dart';
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
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: 'application/json; charset=utf-8',
      headers: {
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, DELETE, POST, PUT, OPTIONS",
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
    final account = sharedPrefsRepository.account;
    if (account != null) {
      final token = account.token;
      if (token.isNotEmpty) {
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

  @lazySingleton
  @factoryMethod
  RoleDao roleDao(AntreeDatabase antreeDatabase) => RoleDao(antreeDatabase);

  @singleton
  AntreeLoadingDialog antreeDialog() => AntreeLoadingDialog();

  @singleton
  CancelToken cancelToken() => CancelToken();
}
