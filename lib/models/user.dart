import 'package:freezed_annotation/freezed_annotation.dart';

import 'role.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String username,
    @Default('') String email,
    @Default('') String password,
    @Default('') String provider,
    @Default(false) bool confirmed,
    @Default(false) bool blocked,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default('') String description,
    @Default(Role()) Role role,
    @Default(0) int merchantId,
    @Default(0) int customerId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> get toRegister => {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "role": role.id,
        "merchantId": merchantId,
        "customerId": customerId
      };
  Map<String, dynamic> get toRegisterUserId => {
        "data": {"user": id}
      };
  Map<String, dynamic> get toUpdateMerchantorCustomerId =>
      {"merchantId": merchantId, "customerId": customerId};

  Map<String, String> get toLogin => {
        "identifier": username,
        "password": password,
      };
}
