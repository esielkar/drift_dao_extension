import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dao_extension/drift_dao_extension.dart';
import 'package:test/test.dart';

import 'generated/todos.dart';

void main() {
  late TodoDB db;
  late TodoDao dao;

  setUp(() {
    db = TodoDB(NativeDatabase.memory());
    dao = db.todoDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('Dao create statement', () async {
    await dao.insert(TodosTableCompanion.insert());
    expect((await dao.getAll()).length, 1);
  });

  test('Dao read by statement', () async {
    final list = [
      TodosTableCompanion(title: Value("1")),
      TodosTableCompanion(title: Value("2")),
      TodosTableCompanion(title: Value("3")),
    ];

    await dao.insertAll(list);
    final todo = await dao.readBy(filter: (table) => table.title.equals("2")).getSingleOrNull();

    expect(todo?.title, "2");
  });

  test('Dao update by id statement', () async {
    String title = 'Title';
    String titleUpdated = "Title updated";

    await dao.insert(TodosTableCompanion(
      title: Value(title),
    ));
    await dao.updateWhere(TodosTableCompanion(title: Value(titleUpdated)),
        filter: (table) => table.id.equals(1));
    final todo = await dao
        .readBy(filter: (table) => table.id.equals(1))
        .getSingleOrNull();

    expect(todo?.title, titleUpdated);
  });

  test('Dao delete by id statement', () async {
    final list = [
      TodosTableCompanion(title: Value("1")),
      TodosTableCompanion(title: Value("2")),
      TodosTableCompanion(title: Value("3")),
    ];

    await dao.insertAll(list);
    await dao.deleteById(TodosTableCompanion(id: Value(1)));

    expect((await dao.getAll()).length, 2);
  });
}
