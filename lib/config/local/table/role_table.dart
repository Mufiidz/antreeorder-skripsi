import 'package:drift/drift.dart';

class RoleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get roleId => integer()();
  TextColumn get name => text()();
  TextColumn get description => text()();
}
