import 'package:antreeorder/config/remote/dio_exceptions.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:dio/dio.dart';

import 'logger.dart';
import 'response_result.dart';

extension AwaitResult<T> on Future<T> {
  Future<ResponseResult<T>> get awaitResponse async {
    ResponseResult<T> responseResult = const ResponseResult.error("EMPTY");
    try {
      await then((value) {
        logger.d('SingleResponse -> $value');
        responseResult = ResponseResult.data(value, null);
      }).catchError((Object obj) {
        if (obj.runtimeType != DioError) {
          responseResult = ResponseResult.error(obj.toString());
          return;
        }
        final errorMessage = getErrorMessage(obj as DioError);
        logger.d(errorMessage);
        responseResult = ResponseResult.error(errorMessage);
      });
    } catch (e) {
      responseResult = ResponseResult.error(e.toString());
    }
    return responseResult;
  }
}

extension AwaitResult2<T> on Future<BaseResponse<T>> {
  Future<ResponseResult<T>> get awaitResponse async {
    ResponseResult<T> responseResult = const ResponseResult.error("EMPTY");
    try {
      await then((value) {
        // logger.d('BaseResponse -> $value');
        responseResult = ResponseResult.data(value.data, value.meta);
      }).catchError((Object obj) {
        if (obj.runtimeType != DioError) {
          responseResult = ResponseResult.error(obj.toString());
          return;
        }
        final errorMessage = getErrorMessage(obj as DioError);
        logger.d(errorMessage);
        responseResult = ResponseResult.error(errorMessage);
      });
    } catch (e) {
      responseResult = ResponseResult.error(e.toString());
    }
    return responseResult;
  }
}

String getErrorMessage(DioError dioError) {
  String message = "ERROR";
  try {
    final res = dioError.response?.data;
    final errorResponse = ErrorResponse.fromJson(res, (obj) => null);
    final errors = errorResponse.error.details.errors;
    String errorMessage = errorResponse.error.message;
    if (errors != null) {
      errorMessage =
          errorResponse.error.details.errors?.first.message ?? errorMessage;
    }
    message = errorMessage;
  } catch (e) {
    message = DioExceptions.fromDioError(dioError).toString();
  }
  return message;
}
