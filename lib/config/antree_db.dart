import 'dart:io';

import 'package:antreeorder/models/category.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'local/category_dao.dart';

part 'antree_db.g.dart';

@DriftDatabase(tables: [Category], daos: [CategoryDao])
class AntreeDatabase extends _$AntreeDatabase {
  AntreeDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'antreeDB.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
