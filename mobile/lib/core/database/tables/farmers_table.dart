import 'package:drift/drift.dart';

/// Local cache of Farmer records, scoped to the current user per
/// OSDS FR-OSDS-003 (NOT a full server mirror — only the caller's
/// assigned district is ever fetched/stored, enforced server-side by
/// the /v1/sync/changes endpoint's scope filtering, per IAPI FR-IAPI-013).
class Farmers extends Table {
  /// Local-only UUID, always present. For offline-created rows this IS
  /// the client_id sent to the server; once confirmed, [serverId] is
  /// populated too — OSDS FR-OSDS-006/007/025.
  TextColumn get id => text()();

  TextColumn get serverId => text().nullable()();
  TextColumn get farmerNumber => text().nullable()(); // FMR-000246, once confirmed
  TextColumn get name => text()();
  TextColumn get districtCode => text()();
  TextColumn get community => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('PROSPECT'))();
  BoolColumn get documentationComplete => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  /// PENDING_SYNC | SYNCING | SYNCED | REJECTED — mirrors the outbox
  /// item's status for THIS record specifically, so the UI can show a
  /// per-row sync badge without joining against the outbox table.
  TextColumn get syncStatus => text().withDefault(const Constant('SYNCED'))();

  @override
  Set<Column> get primaryKey => {id};
}
