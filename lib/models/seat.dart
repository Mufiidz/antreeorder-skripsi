import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'merchant.dart';

part 'seat.freezed.dart';
part 'seat.g.dart';

@freezed
class Seat with _$Seat {
  const Seat._();
  const factory Seat(
      {@Default(0) int id,
      @Default('') String title,
      @Default('') String description,
      @Default(0) int quantity,
      @Default(0) int capacity,
      @Default(Merchant()) Merchant merchant}) = _Seat;

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  factory Seat.fromMap(Map<String, dynamic> map) => _$_Seat(
        id: map['id'].toString().toInt(),
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        quantity: map['quantity'].toString().toInt(),
        capacity: map['capacity'].toString().toInt(),
        merchant: map['merchant'] == null
            ? const Merchant()
            : Merchant.fromJson(map['merchant'] as Map<String, dynamic>),
      );

  BaseBody toAddSeat(int merchantId) => {
        "title": title,
        "description": description,
        "quantity": quantity,
        "capacity": capacity,
        "merchant": merchantId
      };
  BaseBody get toUpdateSeat => {
        "title": title,
        "description": description,
        "quantity": quantity,
        "capacity": capacity,
      };
}
