import 'package:antreeorder/config/api_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer.dart';
import 'merchant.dart';
import 'order.dart';
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
    @Default(0) @JsonKey(name: 'nomor_antri') int antreeNum,
    @Default(0) int remaining,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(Merchant()) Merchant merchant,
  }) = _Antree;

  factory Antree.fromJson(Map<String, dynamic> data) => _$AntreeFromJson(data);

  BaseBody get toUpdateStatus => {"status": status.id};
}
