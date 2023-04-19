import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:antreeorder/models/merchant_product.dart';

part 'merchant.g.dart';

@JsonSerializable()
class Merchant extends Equatable {
  final String id;
  final String name;
  final String username;
  final String description;
  final bool isOpen;
  final List<MerchantProduct> products;

  const Merchant({
    this.id = '',
    this.name = '',
    this.username = '',
    this.description = '',
    this.isOpen = false,
    this.products = const [],
  });

  Merchant copyWith({
    String? id,
    String? name,
    String? username,
    String? description,
    bool? isOpen,
    List<MerchantProduct>? products,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      description: description ?? this.description,
      isOpen: isOpen ?? this.isOpen,
      products: products ?? this.products,
    );
  }

  factory Merchant.fromJson(Map<String, dynamic> data) =>
      _$MerchantFromJson(data);

  Map<String, dynamic> toJson() => _$MerchantToJson(this);

  @override
  List<Object?> get props =>
      [id, name, username, description, isOpen, products];

  @override
  String toString() {
    return 'Merchant(id: $id, name: $name, username: $username, description: $description, isOpen: $isOpen, products: $products)';
  }
}
