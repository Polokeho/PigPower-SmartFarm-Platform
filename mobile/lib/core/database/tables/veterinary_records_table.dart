import 'package:drift/drift.dart';

/// Append-only veterinary records — same reasoning as ProductionBatches.
/// This is the table behind the OSDS §23 "veterinary visit in a
/// no-signal area" end-to-end scenario.
class VeterinaryRecords extends Table {
  TextColumn get id => text()(); // local id / client_id

  TextColumn get serverId => text().nullable()();
  TextColumn get recordNumber => text().nullable()(); // VET-004821, once confirmed
  TextColumn get pigId => text()();
  TextColumn get type => text()(); // VACCINATION | TREATMENT | VISIT
  TextColumn get vaccineTypeCode => text().nullable()();
  DateTimeColumn get administeredAt => dateTime()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('PENDING_SYNC'))();

  @override
  Set<Column> get primaryKey => {id};
}
