import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto extends Equatable {
  final String email;
  final String username;
  final String password;
  final int roleId;

  const LoginDto(
    this.roleId, {
    this.email = '',
    this.username = '',
    this.password = '',
  });

  factory LoginDto.fromJson(Map<String, dynamic> data) =>
      _$LoginDtoFromJson(data);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  @override
  List<Object?> get props => [username, password, email, roleId];

  @override
  String toString() =>
      'LoginDto(roleId: $roleId, username: $username, password: $password, email: $email)';
}
