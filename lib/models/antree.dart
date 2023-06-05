import 'package:antreeorder/config/api_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer.dart';
import 'merchant.dart';
import 'order.dart';
import 'seat.dart';
import 'status_antree.dart';

part 'antree.freezed.dart';
part 'antree.g.dart';

@freezed
class Antree with _$Antree {
  const Antree._();
  const factory Antree({
    @Default(0) int id,
    @Default(Customer()) Customer customer,
    @Default(0) int totalPrice,
    @Default([]) List<Order> orders,
    @Default(StatusAntree()) StatusAntree status,
    @Default(false) bool isVerify,
    @JsonKey(name: 'nomorAntree') int? antreeNum,
    int? remaining,
    @Default(Seat()) Seat seat,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? takenAt,
    @Default(Merchant()) Merchant merchant,
  }) = _Antree;

  factory Antree.fromJson(Map<String, dynamic> data) => _$AntreeFromJson(data);

  BaseBody get toUpdateStatus => {"status": status.id};

  BaseBody toTakeOrder(DateTime takenAt) => {
    "status": 6,
    "isVerify": true,
    "takenAt": takenAt.toIso8601String()
  };
}
