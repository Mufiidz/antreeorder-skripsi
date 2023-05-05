import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:antreeorder/utils/string_ext.dart';

import 'order.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {

  @Assert('quantity >= 0')
  @Assert('price >= 0')
  factory Product(
      {@Default('') String id,
      @Default('') String merchantId,
      @Default('') String title,
      @Default('') String category,
      @Default('') String description,
      @Default(0) int quantity,
      @Default(0) int price}) = _Product;

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      merchantId: map['merchantId'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      description: map['desc'] ?? '',
      quantity: map['quantity'].toString().toInt(),
      price: map['price'].toString().toInt(),
    );
  }
}

extension ProductExt on Product {
  Order toOrder() => Order(productId: id, price: price, product: this);
}