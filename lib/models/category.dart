import 'package:drift/drift.dart';

class Category extends Table {
  TextColumn get title => text().unique()();

  @override
  Set<Column<Object>>? get primaryKey => {title};
}
