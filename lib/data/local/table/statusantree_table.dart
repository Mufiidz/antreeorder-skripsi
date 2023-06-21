import 'package:drift/drift.dart';

class StatusAntreeTable extends Table {
  IntColumn get id => integer()();
  TextColumn get message => text()();
  TextColumn get description => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
