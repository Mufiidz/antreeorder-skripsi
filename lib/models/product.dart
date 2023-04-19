import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String id;
  final String merchantId;
  final String title;
  final String category;
  final String description;
  final int quantity;
  final int price;

  const Product({
    this.id = '',
    this.merchantId = '',
    this.title = '-',
    this.category = '-',
    this.description = '-',
    this.quantity = 0,
    this.price = 0,
  });

  Product copyWith({
    String? id,
    String? merchantId,
    String? title,
    String? category,
    String? description,
    int? quantity,
    int? price,
  }) {
    return Product(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Order toOrder() => Order(productId: id, price: price, product: this);

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      merchantId,
      title,
      category,
      description,
      quantity,
      price,
    ];
  }

  @override
  String toString() {
    return 'Product(id: $id, merchantId: $merchantId, title: $title, category: $category, description: $description, quantity: $quantity, price: $price)';
  }
}
