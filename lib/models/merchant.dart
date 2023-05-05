import 'package:antreeorder/models/login_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'merchant.g.dart';

@JsonSerializable()
class Merchant extends LoginDto {
  final String id;
  final String name;
  final String description;
  final bool isOpen;
  final String token;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final List<Product> products;

  const Merchant({
    this.id = '',
    this.name = '',
    this.description = '',
    this.isOpen = false,
    super.password,
    super.username,
    this.token = '',
    this.createdAt,
    this.updateAt,
    this.products = const [],
  });

  Merchant copyWith(
      {String? id,
      String? name,
      String? description,
      bool? isOpen,
      List<Product>? products,
      String? token,
      DateTime? createdAt,
      DateTime? updateAt}) {
    return Merchant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isOpen: isOpen ?? this.isOpen,
        products: products ?? this.products,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt);
  }

  factory Merchant.fromJson(Map<String, dynamic> data) =>
      _$MerchantFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$MerchantToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      username,
      description,
      isOpen,
      token,
      createdAt,
      updateAt,
      products,
    ];
  }

  @override
  String toString() {
    return 'Merchant(id: $id, name: $name, username: $username, description: $description, isOpen: $isOpen, token: $token, createdAt: $createdAt, updateAt: $updateAt, products: $products)';
  }
}
