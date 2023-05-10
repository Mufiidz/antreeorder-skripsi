import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'content_detail.freezed.dart';

@freezed
class ContentDetail with _$ContentDetail {
  factory ContentDetail(
      {@Default('') String title, @Default('') String value}) = _ContentDetail;
}
