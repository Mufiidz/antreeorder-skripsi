import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'merchant.dart';
import 'order.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  @Assert('quantity >= 0')
  @Assert('price >= 0')
  factory Product(
      {@Default(0) int id,
      @Default('') String title,
      @Default('') String category,
      @Default('') String description,
      @Default(0) int quantity,
      @Default(0) int price,
      @Default(true) bool isAvailable,
      @Default(Merchant()) Merchant merchant}) = _Product;

  factory Product.fromJson(Map<String, dynamic> data) =>
      _$ProductFromJson(data);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString().toInt(),
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

  BaseBody toAddProduct(int merchantId) => {
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "quantity": quantity,
        "merchant": merchantId
      };

  BaseBody get toUpdateProduct => {
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "quantity": quantity,
      };
}
