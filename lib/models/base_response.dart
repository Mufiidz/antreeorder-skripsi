import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse {
  const factory BaseResponse(T data, Meta meta) = _BaseResponse;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ErrorResponse<T> with _$ErrorResponse {
  const factory ErrorResponse(T? data, ResponseError error) = _ErrorResponse;

  factory ErrorResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ErrorResponseFromJson(json, fromJsonT);
}

@freezed
class ResponseError with _$ResponseError {
  const factory ResponseError({
    required int status,
    required String name,
    required String message,
    required Details details,
  }) = _ResponseError;

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);
}

@freezed
class Details with _$Details {
  const factory Details({
    List<ErrorElement>? errors,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}

@freezed
class ErrorElement with _$ErrorElement {
  const factory ErrorElement({
    required List<String> path,
    required String message,
    required String name,
  }) = _ErrorElement;

  factory ErrorElement.fromJson(Map<String, dynamic> json) =>
      _$ErrorElementFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    @Default(Pagination()) Pagination pagination,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    @Default(0) int page,
    @Default(0) int pageSize,
    @Default(0) int pageCount,
    @Default(0) int total,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
