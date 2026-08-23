import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';

enum SyncStatus { idle, syncing, offline, error }

/// The client-side sync engine — 5.6 FR-MOB-005. Lives in `core/sync`
/// as a single service used by every feature's repository, rather than
/// each feature implementing its own offline queue (BR-OSDS-002).
///
/// Responsibilities (mapped to OSDS sections):
///   - ConnectivityMonitor  → §9  (auto-sync triggers)
///   - OutboxProcessor      → §8-10 (priority-ordered, generic outbox table)
///   - SyncApiClient        → calls POST /v1/sync/batch (IAPI FR-IAPI-026)
///   - LocalReconciler      → updates local rows with server-confirmed IDs
class SyncEngine {
  SyncEngine._internal() {
    Connectivity().onConnectivityChanged.listen((results) {
      final hasConnection = results.any((r) => r != ConnectivityResult.none);
      if (hasConnection) {
        // FR-OSDS-013 — automatic sync when connectivity becomes available
        syncNow();
      }
    });
  }

  static final SyncEngine instance = SyncEngine._internal();

  final _db = AppDatabase.instance;
  final _dio = ApiClient.instance.dio;

  final _statusController = StreamController<SyncStatus>.broadcast();
  Stream<SyncStatus> get statusStream => _statusController.stream;

  bool _isSyncing = false;

  /// Live count of items still pending sync — backs the sync status
  /// widget (5.6 FR-MOB-007) via a Riverpod StreamProvider watching this.
  Stream<int> watchPendingCount() {
    final query = _db.select(_db.outboxItems)
      ..where((t) => t.status.isNotValue('CONFIRMED'));
    return query.watch().map((rows) => rows.length);
  }

  /// FR-OSDS-014 — manual sync trigger, e.g. a "Sync Now" button.
  Future<void> syncNow() async {
    if (_isSyncing) return;
    _isSyncing = true;
    _statusController.add(SyncStatus.syncing);

    try {
      final pending = await (_db.select(_db.outboxItems)
            ..where((t) => t.status.isNotValue('CONFIRMED'))
            ..orderBy([(t) => OrderingTerm.asc(t.priorityTier), (t) => OrderingTerm.asc(t.createdAt)]))
          .get();

      if (pending.isEmpty) {
        _statusController.add(SyncStatus.idle);
        return;
      }

      // OSDS FR-OSDS-026 — batch submission, not one item per request.
      final response = await _dio.post('/sync/batch', data: {
        'items': pending
            .map((item) => {
                  'idempotency_key': item.idempotencyKey,
                  'entity_type': item.entityType,
                  'client_id': item.clientId,
                  'operation': 'CREATE',
                  'payload': jsonDecode(item.payloadJson),
                })
            .toList(),
      });

      final results = (response.data['data']['results'] as List).cast<Map<String, dynamic>>();
      await _reconcile(pending, results);

      _statusController.add(SyncStatus.idle);
    } on DioException {
      // OSDS FR-OSDS-030/031 — retry policy with backoff is handled by
      // the next connectivity-restored trigger or manual retry; a full
      // exponential-backoff scheduler is a straightforward extension
      // point here once real device-fleet data justifies tuning it.
      _statusController.add(SyncStatus.offline);
    } catch (_) {
      _statusController.add(SyncStatus.error);
    } finally {
      _isSyncing = false;
    }
  }

  /// LocalReconciler — OSDS FR-OSDS-025/029: updates local rows with
  /// server-confirmed IDs, or surfaces a clear rejection reason.
  Future<void> _reconcile(List<OutboxItem> submitted, List<Map<String, dynamic>> results) async {
    await _db.transaction(() async {
      for (final result in results) {
        final clientId = result['client_id'] as String;
        final matching = submitted.firstWhere((s) => s.clientId == clientId);
        final confirmed = result['status'] == 'CONFIRMED';

        await (_db.update(_db.outboxItems)..where((t) => t.id.equals(matching.id))).write(
          OutboxItemsCompanion(
            status: Value(confirmed ? 'CONFIRMED' : 'REJECTED'),
            errorMessage: Value(confirmed ? null : (result['error']?['message'] as String?)),
          ),
        );

        if (confirmed) {
          final serverId = result['server_id'] as String;
          await _applyServerId(matching.entityType, clientId, serverId);
        }
        // Rejected items remain visible with their error (FR-OSDS-028);
        // the relevant feature screen is responsible for surfacing a
        // retry/edit action — sync_status_widget.dart shows the count.
      }
    });
  }

  Future<void> _applyServerId(String entityType, String clientId, String serverId) async {
    switch (entityType) {
      case 'Farmer':
        await (_db.update(_db.farmers)..where((t) => t.id.equals(clientId))).write(
          FarmersCompanion(serverId: Value(serverId), farmerNumber: Value(serverId), syncStatus: const Value('SYNCED')),
        );
        break;
      case 'ProductionBatch':
        await (_db.update(_db.productionBatches)..where((t) => t.id.equals(clientId))).write(
          ProductionBatchesCompanion(
            serverId: Value(serverId),
            batchNumber: Value(serverId),
            syncStatus: const Value('SYNCED'),
          ),
        );
        break;
      case 'VeterinaryRecord':
        await (_db.update(_db.veterinaryRecords)..where((t) => t.id.equals(clientId))).write(
          VeterinaryRecordsCompanion(
            serverId: Value(serverId),
            recordNumber: Value(serverId),
            syncStatus: const Value('SYNCED'),
          ),
        );
        break;
    }
  }

  /// Adds an item to the outbox — called by feature repositories on
  /// every offline-capable write (5.6 FR-MOB-002).
  Future<void> enqueue({
    required String entityType,
    required String clientId,
    required String idempotencyKey,
    required Map<String, dynamic> payload,
    int priorityTier = 3,
  }) async {
    await _db.into(_db.outboxItems).insert(
          OutboxItemsCompanion.insert(
            entityType: entityType,
            clientId: clientId,
            idempotencyKey: idempotencyKey,
            payloadJson: jsonEncode(payload),
            priorityTier: Value(priorityTier),
            createdAt: DateTime.now(),
          ),
        );
    // Try immediately in case connectivity is already available —
    // if not, the connectivity listener above will pick it up later.
    unawaited(syncNow());
  }
}
