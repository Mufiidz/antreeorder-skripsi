import 'package:antreeorder/models/status_antree.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/local/table/statusantree_table.dart';

part 'statusantree_dao.g.dart';

@injectable
@singleton
@DriftAccessor(tables: [StatusAntreeTable])
class StatusAntreeDao extends DatabaseAccessor<AntreeDatabase>
    with _$StatusAntreeDaoMixin {
  @factoryMethod
  StatusAntreeDao(super.antreeDatabase);

  Future<void> addStatusAntree(StatusAntree statusAntree) async =>
      await into(statusAntreeTable).insert(
          StatusAntreeTableCompanion.insert(
              id: Value(statusAntree.id),
              message: statusAntree.message,
              description: statusAntree.description),
          mode: InsertMode.insertOrReplace);

  Future<List<StatusAntree>> statusesAntree() async =>
      await select(statusAntreeTable).get().then((value) => value
          .map((e) => StatusAntree(
              id: e.id, message: e.message, description: e.description))
          .toList());
}
