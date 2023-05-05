import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'merchant.dart';
import 'user.dart';

part 'account.g.dart';

@JsonSerializable()
class Account extends Equatable {
  final bool isMerchant;
  final User? user;
  final Merchant? merchant;

  const Account({
    required this.isMerchant,
    this.user,
    this.merchant,
  });

  factory Account.fromMap(Map<String, dynamic> data) => _$AccountFromJson(data);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String toEncode() => json.encode(toJson());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  List<Object> get props => [isMerchant, user as Object];

  @override
  String toString() =>
      'Account(isMerchant: $isMerchant, user: $user, merchant: $merchant)';
}
