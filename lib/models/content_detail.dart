import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_detail.freezed.dart';

@freezed
class ContentDetail with _$ContentDetail {
  factory ContentDetail(
      {@Default('') String title, @Default('') String value}) = _ContentDetail;
}
