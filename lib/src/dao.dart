import 'package:drift/drift.dart';

import 'dao_extension.dart';

/// Abstract class for DAO implementations
///
/// {@template drift_dao_extension.dao.dao_generic_definitions}
/// [DB] is the generated dart class which extends [GeneratedDatabase].
/// [S] is the generated dart class which generally extends [Table] or [View]
/// see [TableDao] and/or [ViewDao] for more details.
/// [R] is the associated data class.
/// {@endtemplate}
abstract class Dao<DB extends GeneratedDatabase, S extends HasResultSet, R>
    extends DatabaseAccessor<DB> {
  Dao(super.attachedDatabase);

  /// The entity that this dao uses, generally [Table] or [View]
  ResultSetImplementation<S, R> get entity;
}

/// Abstract class for Dao table implementations
///
/// {@template drift_dao_extension.dao.dao_table_generic_definitions}
/// [DB] is the generated dart class which extends [GeneratedDatabase].
/// [T] is the generated dart class which extends [Table] that represents a
/// table on the generated database.
/// [R] is the associated data class.
/// {@endtemplate}
abstract class TableDao<DB extends GeneratedDatabase, T extends Table, R>
    extends Dao<DB, T, R> {
  TableDao(super.attachedDatabase);

  /// The [TableInfo] that this dao uses.
  /// Note: Any generated [Table] implements [TableInfo].
  TableInfo<T, R> get table;

  @override
  ResultSetImplementation<T, R> get entity => table;
}

/// Abstract class for Dao view implementations
///
/// /// {@template drift_dao_extension.dao.dao_view_generic_definitions}
/// [DB] is the generated dart class which extends [GeneratedDatabase].
/// [V] is the generated dart class which extends [View] that represents a
/// view on the generated database.
/// [R] is the associated data class.
/// {@endtemplate}
abstract class ViewDao<DB extends GeneratedDatabase, V extends View, R>
    extends Dao<DB, V, R> {
  ViewDao(super.attachedDatabase);

  /// The [ViewInfo] that this dao uses.
  /// Note: Any generated [View] implements [ViewInfo].
  ViewInfo<V, R> get view;

  @override
  ResultSetImplementation<V, R> get entity => view;
}

/// Abstract TableDao class that implements all CRUD operations.
///
/// {@macro drift_dao_extension.dao.dao_table_generic_definitions}
abstract class CRUDTableDao<DB extends GeneratedDatabase, T extends Table, R>
    extends TableDao<DB, T, R>
    with
        TableDaoMixinCreate<DB, T, R>,
        DaoMixinReadAll<DB, T, R>,
        DaoMixinReadAllAsStream<DB, T, R>,
        DaoMixinReadBy<DB, T, R>,
        DaoMixinReadByAsStream<DB, T, R>,
        TableDaoMixinUpdate<DB, T, R>,
        TableDaoMixinDelete<DB, T, R> {
  CRUDTableDao(super.attachedDatabase);
}
