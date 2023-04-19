import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';

import '../config/dio_exceptions.dart';
import '../models/api_response.dart';

extension AwaitResult<T> on Future<ApiResponse<T>> {
  Future<ApiResponse<T>> get awaitResult async {
    var apiResponse = ApiResponse<T>();
    await then((value) {
      apiResponse = value;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError);
          apiResponse = onDioError(res, apiResponse);
          break;
        default:
          apiResponse.copyWith(message: 'ERROR');
          break;
      }
    });
    return apiResponse;
  }

  ApiResponse<T> onDioError(DioError error, ApiResponse<T> apiResponse) {
    final res = error.response?.data;
    var apires = apiResponse;

    try {
      apires = ApiResponse.errorResponse("$res");
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      apires.copyWith(message: errorMessage);
      logger.e(errorMessage);
    }
    return apires;
  }
}
