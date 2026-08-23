import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/sync/sync_engine.dart';
import '../models/veterinary_record_model.dart';

/// Mirrors FarmerRepository/ProductionRepository's offline-first pattern
/// (5.6 FR-MOB-002), applied to veterinary records. This is the mobile
/// side of the exact scenario walked through in OSDS §23 — a
/// veterinarian recording a vaccination with zero signal.
class VeterinaryRepository {
  final _db = AppDatabase.instance;
  final _dio = ApiClient.instance.dio;
  final _uuid = const Uuid();

  Stream<List<VeterinaryRecordModel>> watchRecords() {
    return _db.select(_db.veterinaryRecords).watch().map(
          (rows) => rows
              .map((r) => VeterinaryRecordModel(
                    id: r.id,
                    pigId: r.pigId,
                    type: r.type,
                    administeredAt: r.administeredAt,
                    syncStatus: r.syncStatus,
                    vaccineTypeCode: r.vaccineTypeCode,
                    notes: r.notes,
                  ))
              .toList(),
        );
  }

  Future<void> refreshFromServer({DateTime? since}) async {
    final response = await _dio.get('/sync/changes', queryParameters: {
      if (since != null) 'since': since.toIso8601String(),
      'entity_types': 'VeterinaryRecord',
    });

    final records = (response.data['data']['veterinary_records'] as List).cast<Map<String, dynamic>>();

    await _db.transaction(() async {
      for (final r in records) {
        await _db.into(_db.veterinaryRecords).insertOnConflictUpdate(
              VeterinaryRecordsCompanion.insert(
                id: r['id'] as String,
                serverId: Value(r['record_number'] as String?),
                recordNumber: Value(r['record_number'] as String?),
                pigId: r['pig_id'] as String,
                type: r['type'] as String,
                administeredAt: DateTime.parse(r['administered_at'] as String),
                notes: Value(r['notes'] as String?),
                createdAt: DateTime.parse(r['created_at'] as String),
                syncStatus: const Value('SYNCED'),
              ),
            );
      }
    });
  }

  /// Offline-capable capture — TIER 1 priority (OSDS §10: "veterinary
  /// emergency records" rank above production/routine data), matching
  /// the backend's rejection scenario exactly for an unknown pig_id
  /// (5.5 §7 / OSDS §13).
  Future<String> recordVeterinaryEvent({
    required String pigId,
    required String type,
    required DateTime administeredAt,
    String? vaccineTypeCode,
    String? notes,
  }) async {
    final clientId = 'LOCAL-VET-${_uuid.v4()}';
    final now = DateTime.now();

    await _db.into(_db.veterinaryRecords).insert(
          VeterinaryRecordsCompanion.insert(
            id: clientId,
            pigId: pigId,
            type: type,
            administeredAt: administeredAt,
            vaccineTypeCode: Value(vaccineTypeCode),
            notes: Value(notes),
            createdAt: now,
            syncStatus: const Value('PENDING_SYNC'),
          ),
        );

    await SyncEngine.instance.enqueue(
      entityType: 'VeterinaryRecord',
      clientId: clientId,
      idempotencyKey: 'veterinary-create-$clientId',
      priorityTier: 1,
      payload: {
        'client_id': clientId,
        'pig_id': pigId,
        'type': type,
        'administered_at': administeredAt.toIso8601String(),
        if (vaccineTypeCode != null) 'vaccine_type_id': vaccineTypeCode,
        if (notes != null) 'notes': notes,
      },
    );

    return clientId;
  }
}
