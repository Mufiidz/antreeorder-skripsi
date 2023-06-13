import 'package:antreeorder/config/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:antreeorder/models/product.dart';

import 'midtrans_payment.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  final int id;
  final int productId;
  final String note;
  int quantity;
  final int price;
  final String title;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Product? product;
  Order({
    this.productId = 0,
    this.id = 0,
    this.title = '',
    this.note = '',
    this.quantity = 1,
    this.price = 0,
    this.product,
  });

  Order copyWith({
    int? id,
    int? productId,
    String? note,
    String? title,
    int? quantity,
    int? price,
    Product? product,
  }) {
    return Order(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      note: note ?? this.note,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  ItemDetail get toItemMidtrans =>
      ItemDetail(id: '$id', price: price, quantity: quantity, name: title);

  BaseBody get toAddOrder => {
        'product': productId,
        'price': price,
        'quantity': quantity,
        "title": product?.title
      };

  @override
  List<Object?> get props {
    return [
      id,
      productId,
      title,
      note,
      quantity,
      price,
      product,
    ];
  }

  @override
  String toString() {
    return 'Order(id: $id, productId: $productId, note: $note, title: $title, quantity: $quantity, price: $price, product: $product)';
  }
}
