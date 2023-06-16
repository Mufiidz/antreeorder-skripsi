// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_midtrains_response.freezed.dart';
part 'token_midtrains_response.g.dart';

@freezed
class TokenMidtrainsResponse with _$TokenMidtrainsResponse {
  factory TokenMidtrainsResponse(
          {@Default('') String token,
          @Default('') @JsonKey(name: 'redirect_url') String redirectUrl}) =
      _TokenMidtrainsResponse;

  factory TokenMidtrainsResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenMidtrainsResponseFromJson(json);
}
