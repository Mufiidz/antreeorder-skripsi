import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'page.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  final int code;
  final String message;
  final String path;
  final T? data;
  final DateTime? timestamp;
  final Page? page;

  const ApiResponse(
      {this.code = 0,
      this.message = '',
      this.path = '',
      this.data,
      this.timestamp,
      this.page});

  ApiResponse<T> copyWith(
      {int? code,
      String? message,
      String? path,
      T? data,
      DateTime? timestamp,
      Page? page}) {
    return ApiResponse<T>(
        code: code ?? this.code,
        message: message ?? this.message,
        path: path ?? this.path,
        data: data ?? this.data,
        timestamp: timestamp ?? this.timestamp,
        page: page ?? this.page);
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);

  factory ApiResponse.errorResponse(String source) =>
      ApiResponse.errorFromMap(json.decode(source));

  factory ApiResponse.errorFromMap(Map<String, dynamic> map) {
    return ApiResponse<T>(
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      path: map['path'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'ApiResponse(code: $code, message: $message, path: $path, data: $data, timestamp: $timestamp, page: $page)';
  }

  @override
  List<Object?> get props => [code, message, path, data, timestamp, page];
}
