import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String username;
  String password;
  String token;
  DateTime? createdAt;
  DateTime? updateAt;

  User({
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

  factory User.fromJson(Map<String,dynamic> data) => _$UserFromJson(data);

  Map<String,dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, password: $password, token: $token,' 
    ' createdAt: $createdAt, updateAt: $updateAt)';
  }
}
