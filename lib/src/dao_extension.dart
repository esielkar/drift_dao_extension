import 'package:drift/drift.dart'
    show
        Batch,
        DeleteStatement,
        Expression,
        GeneratedDatabase,
        HasResultSet,
        InsertMode,
        InsertStatement,
        Insertable,
        OrderingTerm,
        Selectable,
        Table,
        UpsertClause,
        UpdateStatement;

import 'dao.dart' show Dao, TableDao;

extension DaoReadExtension<DB extends GeneratedDatabase, S extends HasResultSet,
    R> on Dao<DB, S, R> {
  /// Returns a [Selectable] applying the given filters, clauses, limit and
  /// offset.
  Selectable<R> read({
    Expression<bool> Function(S base)? filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) {
    final stmt = select(entity);
    if (filter != null) stmt.where(filter);
    if (clauses != null) stmt.orderBy(clauses);
    if (limit != null) stmt.limit(limit, offset: offset);

    return stmt;
  }

  /// Returns a [Selectable] applying the given filters, clauses, limit and
  /// offset.
  /// Also see [read].
  Selectable<R> readBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      read(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      );

  /// Returns a [Selectable] applying the given clauses, limit and offset.
  /// Also see [read].
  Selectable<R> readAll({
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      read(
        clauses: clauses,
        limit: limit,
        offset: offset,
      );
}

/// Mixin for read all operation on a [Dao].
///
/// {@macro drift_dao_extension.dao.dao_generic_definitions}
mixin DaoMixinReadAll<DB extends GeneratedDatabase, S extends HasResultSet, R>
    on Dao<DB, S, R> {
  /// {@template drift_dao_extension.dao_extension.daoMixinRead.getAll}
  /// Returns a [Future]<[List]> applying the given clauses, limit and offset.
  /// {@endtemplate}
  Future<List<R>> getAll({
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readAll(clauses: clauses, limit: limit, offset: offset).get();
}

/// Mixin for read by operations on a [Dao].
///
/// {@macro drift_dao_extension.dao.dao_generic_definitions}
mixin DaoMixinReadBy<DB extends GeneratedDatabase, S extends HasResultSet, R>
    on Dao<DB, S, R> {
  /// {@template drift_dao_extension.dao_extension.daoMixinRead.getSingleBy}
  /// Returns a [Future]<[R]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Future<R> getSingleBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).getSingle();

  /// {@template drift_dao_extension.dao_extension.daoMixinRead.getSingleOrNullBy}
  /// Returns a [Future]<[R?]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Future<R?> getSingleOrNullBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).getSingleOrNull();

  /// {@template drift_dao_extension.dao_extension.daoMixinRead.getBy}
  /// Returns a [Future]<[List]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Future<List<R>> getBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).get();
}

/// Mixin for read all operation as [Stream] on a [Dao].
///
/// {@macro drift_dao_extension.dao.dao_generic_definitions}
mixin DaoMixinReadAllAsStream<DB extends GeneratedDatabase,
    S extends HasResultSet, R> on Dao<DB, S, R> {
  /// {@template drift_dao_extension.dao_extension.daoMixinRead.watchAll}
  /// Returns a [Stream]<[List]> applying the given clauses, limit and offset.
  /// {@endtemplate}
  Stream<List<R>> watchAll({
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readAll(clauses: clauses, limit: limit, offset: offset).watch();
}

/// Mixin for read by operations as [Stream] on a [Dao].
///
/// {@macro drift_dao_extension.dao.dao_generic_definitions}
mixin DaoMixinReadByAsStream<DB extends GeneratedDatabase,
    S extends HasResultSet, R> on Dao<DB, S, R> {
  /// {@template drift_dao_extension.dao_extension.daoMixinRead.watchSingleBy}
  /// Returns a [Stream]<[R]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Stream<R> watchSingleBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).watchSingle();

  /// {@template drift_dao_extension.dao_extension.daoMixinRead.watchSingleOrNullBy}
  /// Returns a [Stream]<[R?]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Stream<R?> watchSingleOrNullBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).watchSingleOrNull();

  /// {@template drift_dao_extension.dao_extension.daoMixinRead.watchBy}
  /// Returns a [Stream]<[List]> applying the given filters, clauses, limit and
  /// offset.
  /// {@endtemplate}
  Stream<List<R>> watchBy({
    required Expression<bool> Function(S base) filter,
    List<OrderingTerm Function(S base)>? clauses,
    int? limit,
    int? offset,
  }) =>
      readBy(
        filter: filter,
        clauses: clauses,
        limit: limit,
        offset: offset,
      ).watch();
}

/// Mixin for create operation on a [TableDao].
///
/// {@macro drift_dao_extension.dao.dao_table_generic_definitions}
mixin TableDaoMixinCreate<DB extends GeneratedDatabase, T extends Table, R>
    on TableDao<DB, T, R> {
  /// Inserts a row constructed from the fields in entity.
  /// Also see [InsertStatement.insert]
  Future<int> insert(
    Insertable<R> entity, {
    InsertMode? mode,
    UpsertClause<T, R>? onConflict,
  }) =>
      into(table).insert(
        entity,
        mode: mode,
        onConflict: onConflict,
      );

  /// Inserts all rows constructed from the fields in each entity of entities [List].
  /// Also see [Batch.insertAll]
  Future<void> insertAll(
    List<Insertable<R>> entities, {
    InsertMode? mode,
    UpsertClause<T, R>? onConflict,
  }) =>
      batch((batch) => batch.insertAll(
            table,
            entities,
            mode: mode,
            onConflict: onConflict,
          ));
}

/// Mixin for update and replace by id operations on a [TableDao].
///
/// {@macro drift_dao_extension.dao.dao_table_generic_definitions}
mixin TableDaoMixinUpdate<DB extends GeneratedDatabase, T extends Table, R>
    on TableDao<DB, T, R> {
  /// Writes all non-null fields from entity into the columns of the row(s)
  /// applying the given filter.
  /// Also see [update] and [UpdateStatement.write]
  Future<int> updateWhere(Insertable<R> entity,
          {required Expression<bool> Function(T table) filter}) =>
      (update(table)..where(filter)).write(entity);

  /// Replaces the old version of entity that is stored in the database with the
  /// fields of the entity provided here.
  /// Also see [update] and [UpdateStatement.replace]
  Future<bool> replace(Insertable<R> entity) => update(table).replace(entity);
}

/// Mixin for delete operation on a [TableDao].
///
/// {@macro drift_dao_extension.dao.dao_table_generic_definitions}
mixin TableDaoMixinDelete<DB extends GeneratedDatabase, T extends Table, R>
    on TableDao<DB, T, R> {
  /// Deletes just this entity.
  /// Also see [delete] and [DeleteStatement.delete]
  Future<int> deleteByPrimaryKey(Insertable<R> entity) => delete(table).delete(entity);

  Future<int> deleteWhere(
    Insertable<R> entity, {
    required Expression<bool> Function(T table) filter,
  }) =>
      (delete(table)..where(filter)).go();
}
