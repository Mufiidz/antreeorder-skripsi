import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_antree.g.dart';

@JsonSerializable()
class StatusAntree extends Equatable {
  final int id;
  final String message;
  const StatusAntree({
    this.id = 0,
    this.message = '-',
  });
  factory StatusAntree.fromJson(Map<String, dynamic> data) =>
      _$StatusAntreeFromJson(data);

  Map<String, dynamic> toJson() => _$StatusAntreeToJson(this);

  @override
  String toString() => 'StatusAntree(id: $id, message: $message)';

  @override
  List<Object> get props => [id, message];
}
