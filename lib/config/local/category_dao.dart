import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/local/table/category.dart';
import 'package:drift/drift.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AntreeDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AntreeDatabase antreeDatabase) : super(antreeDatabase);

  Future<void> addCategory(String category) async => await into(this.category)
      .insert(CategoryCompanion.insert(title: category),
          mode: InsertMode.insertOrReplace);

  Future<List<CategoryData>> categories() async => await select(category).get();

  Future<int> deleteCategory(String category) async =>
      await (delete(this.category)..where((tbl) => tbl.title.equals(category)))
          .go();
}
