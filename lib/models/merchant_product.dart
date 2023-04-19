import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_product.g.dart';

@JsonSerializable()
class MerchantProduct extends Equatable {
  final String id;
  final String merchantId;
  final String title;
  final String category;
  final String description;
  final int quantity;
  final int price;

  const MerchantProduct({
    this.id = '',
    this.merchantId = '',
    this.title = '',
    this.category = '',
    this.description = '',
    this.quantity = 0,
    this.price = 0,
  });

  MerchantProduct copyWith({
    String? id,
    String? merchantId,
    String? title,
    String? category,
    String? description,
    int? quantity,
    int? price,
  }) {
    return MerchantProduct(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  factory MerchantProduct.fromJson(Map<String, dynamic> data) =>
      _$MerchantProductFromJson(data);

  Map<String, dynamic> toJson() => _$MerchantProductToJson(this);

  @override
  String toString() {
    return 'MerchantProduct(id: $id, merchantId: $merchantId, title: $title, category: $category, description: $description, quantity: $quantity, price: $price)';
  }

  @override
  List<Object?> get props =>
      [id, merchantId, title, category, description, quantity, price];
}
