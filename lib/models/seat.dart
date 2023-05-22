import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat.g.dart';

@JsonSerializable()
class Seat extends Equatable {
  final int id;
  final String title;
  final String description;
  final int quantity;
  final int capacity;

  const Seat(this.id,
      {this.title = '',
      this.description = '',
      this.quantity = 0,
      this.capacity = 0});

  factory Seat.fromJson(Map<String, dynamic> data) => _$SeatFromJson(data);

  Map<String, dynamic> toJson() => _$SeatToJson(this);

  Seat copyWith({
    int? id,
    String? title,
    String? description,
    int? quantity,
    int? capacity,
  }) {
    return Seat(
      id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      capacity: capacity ?? this.capacity,
    );
  }

  @override
  String toString() {
    return 'Seat(id: $id, title: $title, description: $description, quantity: $quantity, capacity: $capacity)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      quantity,
      capacity,
    ];
  }
}
