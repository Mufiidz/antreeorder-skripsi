import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'merchant.dart';
import 'order.dart';
import 'status_antree.dart';

part 'antree.freezed.dart';
part 'antree.g.dart';

@freezed
class Antree with _$Antree {
  const factory Antree({
    @Default('') String id,
    @Default('') String merchantId,
    @Default('') String userId,
    @Default(0) int totalPrice,
    @Default([]) List<Order> orders,
    @Default(StatusAntree()) StatusAntree status,
    @Default(false) bool isVerify,
    @Default(0) @JsonKey(name: 'nomor_antri') int antreeNum,
    @Default(0) int remaining,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(Merchant())
    @JsonKey(includeToJson: false, includeFromJson: false)
        Merchant? merchant,
  }) = _Antree;

  factory Antree.fromJson(Map<String, dynamic> data) => _$AntreeFromJson(data);
}
