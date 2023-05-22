import 'package:antreeorder/utils/export_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String type,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(0) int nbUsers,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}

extension RoleMapper on Role {
  bool get isMerchant => name.contain('merchant', ignoreCase: true);
  bool get isCustomer => name.contain('customer', ignoreCase: true);
}
