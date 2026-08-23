import 'package:drift/drift.dart';

/// Locally cached SACM reference/lookup data (districts, breeds, vaccine
/// types) — OSDS FR-OSDS-005, so offline forms still populate dropdowns
/// with zero connectivity. Refreshed from GET /v1/sync/reference-data.
class LookupValues extends Table {
  TextColumn get lookupTableCode => text()(); // e.g. 'district', 'pig_breed'
  TextColumn get code => text()();
  TextColumn get label => text()();
  TextColumn get metadataJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {lookupTableCode, code};
}
