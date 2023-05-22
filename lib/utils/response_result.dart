import 'package:antreeorder/models/base_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_result.freezed.dart';

@Freezed(genericArgumentFactories: true)
class ResponseResult<T> with _$ResponseResult<T> {
  const factory ResponseResult.data(T data, Meta? meta) = ResponseResultData;
  const factory ResponseResult.error(String message) = ResponseResultError;
}
