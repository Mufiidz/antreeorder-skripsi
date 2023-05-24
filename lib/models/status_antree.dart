import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_antree.freezed.dart';
part 'status_antree.g.dart';

@freezed
class StatusAntree with _$StatusAntree {
  const StatusAntree._();
  const factory StatusAntree({
    @Default(0) int id,
    @Default('No Status') String message,
    @Default('') String description,
    @Default('') String altMessage,
  }) = _StatusAntree;

  factory StatusAntree.fromJson(Map<String, dynamic> json) =>
      _$StatusAntreeFromJson(json);
}
