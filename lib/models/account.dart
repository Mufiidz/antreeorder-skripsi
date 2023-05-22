import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'account.freezed.dart';
part 'account.g.dart';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

@freezed
class Account with _$Account {
  factory Account(
      {@Default(false) bool isMerchant,
      @Default(User()) User user,
      @Default('') String token}) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
