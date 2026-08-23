import 'package:drift/drift.dart';

/// The single generic outbox table used by EVERY feature — 5.6
/// FR-MOB-006, implementing BR-OSDS-002 ("individual modules shall not
/// build their own bespoke offline queues"). This is what lets the
/// sync engine (core/sync/sync_engine.dart) be one shared service
/// instead of duplicated per feature.
class OutboxItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entityType => text()(); // 'Farmer' | 'ProductionBatch' | 'VeterinaryRecord'
  TextColumn get clientId => text()(); // matches the row's local id in its own table
  TextColumn get idempotencyKey => text().unique()(); // OSDS FR-OSDS-022
  TextColumn get payloadJson => text()();

  /// TIER_1 (vet emergencies) .. TIER_5 (reference data) — OSDS §10.
  IntColumn get priorityTier => integer().withDefault(const Constant(3))();

  /// CREATED | QUEUED | UPLOADING | SERVER_VALIDATING | CONFIRMED | REJECTED
  /// — OSDS §8/§10 lifecycle.
  TextColumn get status => text().withDefault(const Constant('QUEUED'))();

  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
