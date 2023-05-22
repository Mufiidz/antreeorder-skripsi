
import 'package:antreeorder/models/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_response.freezed.dart';
part 'role_response.g.dart';

@freezed
class RoleResponse with _$RoleResponse {
  factory RoleResponse(List<Role> roles) = _RoleResponse;
	
  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
			_$RoleResponseFromJson(json);
}
