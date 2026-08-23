import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/farmers_table.dart';
import 'tables/production_batches_table.dart';
import 'tables/veterinary_records_table.dart';
import 'tables/outbox_items_table.dart';
import 'tables/lookup_values_table.dart';

part 'app_database.g.dart';

/// The Flutter app's local embedded database — 5.6 AD-MOB-002 / OSDS
/// FR-OSDS-002. Requires Drift's code generator to produce
/// `app_database.g.dart` (see project README — this file will not
/// compile until `dart run build_runner build` has been run locally).
@DriftDatabase(
  tables: [Farmers, ProductionBatches, VeterinaryRecords, OutboxItems, LookupValues],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Singleton — one database instance for the app's lifetime.
  static final AppDatabase instance = AppDatabase();

  @override
  int get schemaVersion => 1;

  /// OSDS FR-OSDS-039 — clear all locally cached data on logout or
  /// deregistration (paired with SecureStorage.clearTokens()).
  Future<void> wipeAllLocalData() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pigpower.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
