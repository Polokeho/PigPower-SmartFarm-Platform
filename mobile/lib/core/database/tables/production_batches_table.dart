import 'package:drift/drift.dart';

/// Append-only production entries (per OSDS §11's conflict-resolution
/// table — "each entry is a new fact, not a mutation of a prior one"),
/// so there is deliberately no "dirty/edited" concept here, only
/// created-locally vs. confirmed-by-server.
class ProductionBatches extends Table {
  TextColumn get id => text()(); // local id / client_id

  TextColumn get serverId => text().nullable()();
  TextColumn get batchNumber => text().nullable()(); // PROD-004821, once confirmed
  TextColumn get farmId => text()(); // local farm id or server farm id
  TextColumn get pigIdsJson => text()(); // JSON-encoded list of pig ids
  RealColumn get weightKg => real().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('RECORDED'))();

  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('PENDING_SYNC'))();

  @override
  Set<Column> get primaryKey => {id};
}
