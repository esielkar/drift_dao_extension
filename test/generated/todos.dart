import 'package:drift/drift.dart';
import 'package:drift_dao_extension/src/dao.dart';

part 'todos.g.dart';

mixin AutoIncrement on Table {
  IntColumn get id => integer().autoIncrement()();
}

@DataClassName('TodoEntry')
class TodosTable extends Table with AutoIncrement {
  @override
  String get tableName => 'Todos';

  TextColumn get title => text().nullable()();

  TextColumn get content => text().nullable()();
}

@DriftDatabase(tables: [TodosTable], daos: [TodoDao])
class TodoDB extends _$TodoDB {
  TodoDB([QueryExecutor? e]) : super(e ?? _nullExecutor) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [TodosTable])
class TodoDao extends CRUDTableDao<TodoDB, TodosTable, TodoEntry>
    with _$TodoDaoMixin {
  TodoDao(super.attachedDatabase);

  @override
  TableInfo<TodosTable, TodoEntry> get table => todosTable;
}

QueryExecutor get _nullExecutor =>
    LazyDatabase(() => throw UnsupportedError('stub'));
