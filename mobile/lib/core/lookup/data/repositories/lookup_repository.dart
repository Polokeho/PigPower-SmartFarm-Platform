import 'package:drift/drift.dart';
import '../../../database/app_database.dart';
import '../../../network/api_client.dart';

/// Reference/lookup data repository — OSDS FR-OSDS-005. Populates the
/// local `LookupValues` cache from `GET /v1/sync/reference-data` so
/// offline forms (district, pig breed, vaccine type dropdowns, etc.)
/// have real data instead of hard-coded lists, with zero connectivity
/// required after the first successful pull.
///
/// This closes the gap flagged in the mobile README and confirmed in
/// `OfflineDataArchitecture.md` §3.5: the table and endpoint both
/// existed already, but nothing called the read path.
class LookupRepository {
  final _db = AppDatabase.instance;
  final _dio = ApiClient.instance.dio;

  /// Local-first read — same pattern as FarmerRepository.watchFarmers().
  /// UI can watch this and rebuild automatically once refreshFromServer()
  /// populates the table, with no explicit reload wiring needed.
  Stream<List<LookupValue>> watchTable(String lookupTableCode) {
    final query = _db.select(_db.lookupValues)
      ..where((t) => t.lookupTableCode.equals(lookupTableCode));
    return query.watch();
  }

  /// One-shot local read for places that just need a snapshot (e.g. a
  /// dropdown's initial build) rather than a live stream.
  Future<List<LookupValue>> getTable(String lookupTableCode) {
    final query = _db.select(_db.lookupValues)
      ..where((t) => t.lookupTableCode.equals(lookupTableCode));
    return query.get();
  }

  /// Pulls the full reference-data set and replaces the local cache.
  /// Called on app start (see app.dart) and available for a manual
  /// pull-to-refresh later if reference data changes mid-session.
  ///
  /// Response shape (OSDS FR-OSDS-005 / backend `reference_data`
  /// endpoint): `{ "<table_code>": [{"code","label","metadata"}, ...] }`.
  Future<void> refreshFromServer() async {
    final response = await _dio.get('/sync/reference-data');
    final tables = (response.data['data'] as Map<String, dynamic>);

    await _db.transaction(() async {
      for (final entry in tables.entries) {
        final tableCode = entry.key;
        final values = (entry.value as List).cast<Map<String, dynamic>>();

        for (final v in values) {
          await _db.into(_db.lookupValues).insertOnConflictUpdate(
                LookupValuesCompanion.insert(
                  lookupTableCode: tableCode,
                  code: v['code'] as String,
                  label: v['label'] as String,
                  metadataJson: Value(
                    v['metadata'] == null ? null : v['metadata'].toString(),
                  ),
                ),
              );
        }
      }
    });
  }
}
