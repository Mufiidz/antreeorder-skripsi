import 'package:antreeorder/models/login_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends LoginDto {
  final String id;
  final String name;
  final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id = "",
    this.name = "",
    this.token = "",
    super.username,
    super.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, password: $password, token: $token,'
        ' createdAt: $createdAt, updateAt: $updatedAt)';
  }

  @override
  List<Object?> get props =>
      [id, name, username, password, token, createdAt, updatedAt];
}
