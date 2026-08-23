import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/sync/sync_engine.dart';
import '../models/production_batch_model.dart';

/// Mirrors FarmerRepository's offline-first pattern (5.6 FR-MOB-002),
/// applied to production entries. Since production entries are
/// append-only (OSDS §11), there is deliberately no update method here
/// — only watch/create, matching the backend's ProductionService.
class ProductionRepository {
  final _db = AppDatabase.instance;
  final _dio = ApiClient.instance.dio;
  final _uuid = const Uuid();

  Stream<List<ProductionBatchModel>> watchBatches() {
    return _db.select(_db.productionBatches).watch().map(
          (rows) => rows
              .map((r) => ProductionBatchModel(
                    id: r.id,
                    farmId: r.farmId,
                    pigIds: (jsonDecode(r.pigIdsJson) as List).cast<String>(),
                    recordedAt: r.recordedAt,
                    status: r.status,
                    syncStatus: r.syncStatus,
                    weightKg: r.weightKg,
                    notes: r.notes,
                  ))
              .toList(),
        );
  }

  Future<void> refreshFromServer({DateTime? since}) async {
    final response = await _dio.get('/sync/changes', queryParameters: {
      if (since != null) 'since': since.toIso8601String(),
      'entity_types': 'ProductionBatch',
    });

    final batches = (response.data['data']['production_batches'] as List).cast<Map<String, dynamic>>();

    await _db.transaction(() async {
      for (final b in batches) {
        await _db.into(_db.productionBatches).insertOnConflictUpdate(
              ProductionBatchesCompanion.insert(
                id: b['id'] as String,
                serverId: Value(b['batch_number'] as String?),
                batchNumber: Value(b['batch_number'] as String?),
                farmId: b['farm_id'] as String? ?? '',
                pigIdsJson: jsonEncode(b['pig_ids'] ?? []),
                weightKg: Value((b['weight_kg'] as num?)?.toDouble()),
                recordedAt: DateTime.parse(b['recorded_at'] as String),
                notes: Value(b['notes'] as String?),
                status: Value(b['status'] as String? ?? 'RECORDED'),
                createdAt: DateTime.parse(b['created_at'] as String),
                syncStatus: const Value('SYNCED'),
              ),
            );
      }
    });
  }

  /// Offline-capable capture — this is the exact call path the OSDS §23
  /// scenario walks through: works with zero connectivity, queues in
  /// the outbox at TIER 2 priority (collection/production is more
  /// time-sensitive than routine reference data, per OSDS §10, though
  /// veterinary emergencies still rank above it at TIER 1).
  Future<String> recordProduction({
    required String farmId,
    required List<String> pigIds,
    double? weightKg,
    String? notes,
  }) async {
    final clientId = 'LOCAL-PROD-${_uuid.v4()}';
    final now = DateTime.now();

    await _db.into(_db.productionBatches).insert(
          ProductionBatchesCompanion.insert(
            id: clientId,
            farmId: farmId,
            pigIdsJson: jsonEncode(pigIds),
            weightKg: Value(weightKg),
            recordedAt: now,
            notes: Value(notes),
            createdAt: now,
            syncStatus: const Value('PENDING_SYNC'),
          ),
        );

    await SyncEngine.instance.enqueue(
      entityType: 'ProductionBatch',
      clientId: clientId,
      idempotencyKey: 'production-create-$clientId',
      priorityTier: 2,
      payload: {
        'client_id': clientId,
        'farm_id': farmId,
        'pig_ids': pigIds,
        'recorded_at': now.toIso8601String(),
        if (weightKg != null) 'weight_kg': weightKg,
        if (notes != null) 'notes': notes,
      },
    );

    return clientId;
  }
}
