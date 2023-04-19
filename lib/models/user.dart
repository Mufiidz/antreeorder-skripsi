import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String name;
  final String username;
  final String password;
  final String token;
  final DateTime? createdAt;
  final DateTime? updateAt;

  const User({
    this.id = "",
    this.name = "",
    this.username = "",
    this.password = "",
    this.token = "",
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toRegister() => {
        "name": name,
        "username": username,
        "password": password,
      };

  Map<String, dynamic> toLogin() => {
        "username": username,
        "password": password,
      };

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, password: $password, token: $token,'
        ' createdAt: $createdAt, updateAt: $updateAt)';
  }

  @override
  List<Object?> get props =>
      [id, name, username, password, token, createdAt, updateAt];
}
