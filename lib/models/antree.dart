import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:antreeorder/models/status_antree.dart';

import 'order.dart';

part 'antree.g.dart';

@JsonSerializable()
class Antree extends Equatable {
  final String id;
  final String merchantId;
  final String userId;
  final int totalPrice;
  @JsonKey(name: 'listOrder')
  final List<Order> orders;
  final StatusAntree status;
  final bool isVerify;
  @JsonKey(name: 'nomor_antri')
  final int antreeNum;
  final int remaining;

  const Antree(
      {this.id = '',
      this.merchantId = '',
      this.userId = '',
      this.totalPrice = 0,
      this.orders = const [],
      this.status = const StatusAntree(),
      this.isVerify = false,
      this.antreeNum = 0,
      this.remaining = 0});

  Antree copyWith({
    String? id,
    String? merchantId,
    String? userId,
    int? totalPrice,
    List<Order>? orders,
  }) {
    return Antree(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      orders: orders ?? this.orders,
    );
  }

  factory Antree.fromJson(Map<String, dynamic> data) => _$AntreeFromJson(data);

  Map<String, dynamic> toJson() => _$AntreeToJson(this);

  @override
  String toString() {
    return 'Antree(id: $id, merchantId: $merchantId, userId: $userId, totalPrice: $totalPrice, orders: $orders, status: $status, isVerify: $isVerify, antreeNum: $antreeNum, remaining: $remaining)';
  }

  @override
  List<Object> get props {
    return [
      id,
      merchantId,
      userId,
      totalPrice,
      orders,
      status,
      isVerify,
      antreeNum,
      remaining,
    ];
  }
}
