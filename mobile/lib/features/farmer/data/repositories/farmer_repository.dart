import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/sync/sync_engine.dart';
import '../models/farmer_model.dart';

/// Implements the offline-first repository pattern described in 5.6
/// FR-MOB-002: reads return local data immediately (live Drift stream),
/// while writes go to the local database + outbox first, then sync.
class FarmerRepository {
  final _db = AppDatabase.instance;
  final _dio = ApiClient.instance.dio;
  final _uuid = const Uuid();

  /// Reads are always local-first — the UI never blocks on a network
  /// call just to show a farmer list. See [refreshFromServer] for the
  /// separate, explicit pull of server data.
  Stream<List<FarmerModel>> watchFarmers() {
    return _db.select(_db.farmers).watch().map(
          (rows) => rows
              .map((r) => FarmerModel(
                    id: r.id,
                    name: r.name,
                    districtCode: r.districtCode,
                    status: r.status,
                    syncStatus: r.syncStatus,
                    community: r.community,
                    phone: r.phone,
                  ))
              .toList(),
        );
  }

  /// Pulls confirmed server data via the delta-sync endpoint
  /// (IAPI FR-IAPI-028) and merges it into the local cache. Called on
  /// app start and pull-to-refresh — never blocks reads from proceeding
  /// against whatever is already cached locally.
  Future<void> refreshFromServer({DateTime? since}) async {
    final response = await _dio.get('/sync/changes', queryParameters: {
      if (since != null) 'since': since.toIso8601String(),
      'entity_types': 'Farmer',
    });

    final farmers = (response.data['data']['farmers'] as List).cast<Map<String, dynamic>>();

    await _db.transaction(() async {
      for (final f in farmers) {
        await _db.into(_db.farmers).insertOnConflictUpdate(
              FarmersCompanion.insert(
                id: f['id'] as String,
                serverId: Value(f['farmer_number'] as String?),
                farmerNumber: Value(f['farmer_number'] as String?),
                name: f['name'] as String,
                districtCode: (f['district'] ?? '') as String,
                community: Value(f['community'] as String?),
                phone: Value(f['phone'] as String?),
                status: Value(f['status'] as String? ?? 'PROSPECT'),
                createdAt: DateTime.parse(f['created_at'] as String),
                updatedAt: DateTime.parse(f['updated_at'] as String),
                syncStatus: const Value('SYNCED'),
              ),
            );
      }
    });
  }

  /// Offline-capable create — 5.6 FR-MOB-002 / OSDS FR-OSDS-006.
  /// Writes locally + enqueues in the outbox immediately; the sync
  /// engine handles actually reaching the server whenever connectivity
  /// allows, with no blocking network call on this call path at all.
  Future<String> createFarmer({
    required String name,
    required String districtCode,
    String? community,
    String? phone,
  }) async {
    final clientId = 'LOCAL-FMR-${_uuid.v4()}';
    final now = DateTime.now();

    await _db.into(_db.farmers).insert(
          FarmersCompanion.insert(
            id: clientId,
            name: name,
            districtCode: districtCode,
            community: Value(community),
            phone: Value(phone),
            createdAt: now,
            updatedAt: now,
            syncStatus: const Value('PENDING_SYNC'),
          ),
        );

    await SyncEngine.instance.enqueue(
      entityType: 'Farmer',
      clientId: clientId,
      idempotencyKey: 'farmer-create-$clientId',
      priorityTier: 3,
      payload: {
        'client_id': clientId,
        'name': name,
        'district': districtCode,
        if (community != null) 'community': community,
        if (phone != null) 'phone': phone,
      },
    );

    return clientId;
  }
}
