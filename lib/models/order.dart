import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:antreeorder/models/product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  final String productId;
  final String note;
  int quantity;
  final int price;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Product? product;
  Order({
    this.productId = '',
    this.note = '',
    this.quantity = 1,
    this.price = 0,
    this.product,
  });

  Order copyWith({
    String? productId,
    String? note,
    int? quantity,
    int? price,
    Product? product,
  }) {
    return Order(
      productId: productId ?? this.productId,
      note: note ?? this.note,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object?> get props {
    return [
      productId,
      note,
      quantity,
      price,
      product,
    ];
  }

  @override
  String toString() {
    return 'Order(productId: $productId, note: $note, quantity: $quantity, price: $price, product: $product)';
  }
}
