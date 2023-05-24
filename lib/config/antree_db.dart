import 'dart:io';

import 'package:antreeorder/config/env.dart';
import 'package:antreeorder/config/local/dao/category_dao.dart';
import 'package:antreeorder/config/local/dao/role_dao.dart';
import 'package:antreeorder/config/local/dao/statusantree_dao.dart';
import 'package:antreeorder/config/local/table/category.dart';
import 'package:antreeorder/config/local/table/role_table.dart';
import 'package:antreeorder/config/local/table/statusantree_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'antree_db.g.dart';

@DriftDatabase(
    tables: [Category, RoleTable, StatusAntreeTable],
    daos: [CategoryDao, RoleDao, StatusAntreeDao])
class AntreeDatabase extends _$AntreeDatabase {
  AntreeDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async => await migrator.createAll(),
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.createTable(statusAntreeTable);
          }
        },
      );
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, Env.dbFileName));
      return NativeDatabase.createInBackground(file);
    });
