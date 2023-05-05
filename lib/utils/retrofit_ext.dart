import 'package:antreeorder/config/remote/dio_exceptions.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:dio/dio.dart';

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
    logger.d(res);
    var apires = apiResponse;

    try {
      apires = ApiResponse.errorFromMap(res);
      logger.d(apires);
    } catch (e) {
      logger.d(e);
      final errorMessage = DioExceptions.fromDioError(error).toString();
      apires = apires.copyWith(message: errorMessage);
      logger.e(errorMessage);
    }
    return apires;
  }
}
