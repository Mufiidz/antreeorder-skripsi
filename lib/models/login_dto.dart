import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto extends Equatable {
  final String username;
  final String password;

  const LoginDto({
    this.username = '',
    this.password = '',
  });

  factory LoginDto.fromJson(Map<String, dynamic> data) =>
      _$LoginDtoFromJson(data);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
  

  @override
  List<Object?> get props => [username, password];

  @override
  String toString() => 'LoginDto(username: $username, password: $password)';
}
