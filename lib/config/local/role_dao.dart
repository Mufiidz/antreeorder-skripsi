import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/local/table/role_table.dart';
import 'package:antreeorder/models/role.dart';
import 'package:drift/drift.dart';

part 'role_dao.g.dart';

@DriftAccessor(tables: [RoleTable])
class RoleDao extends DatabaseAccessor<AntreeDatabase> with _$RoleDaoMixin {
  RoleDao(AntreeDatabase antreeDatabase) : super(antreeDatabase);

  Future<void> addRole(Role role) async => await into(roleTable).insert(
      RoleTableCompanion.insert(
          roleId: role.id, name: role.name, description: role.description),
      mode: InsertMode.insertOrReplace);

  Future<List<Role>> roles() async =>
      await select(roleTable).get().then((value) => value
          .map((e) => Role(
              id: e.id,
              name: e.name,
              description: e.description,
              type: e.name.toLowerCase(),
              createdAt: null,
              updatedAt: null,
              nbUsers: 0))
          .toList());
}
