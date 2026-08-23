import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../sync/sync_engine.dart';

final _pendingSyncCountProvider = StreamProvider<int>((ref) {
  return SyncEngine.instance.watchPendingCount();
});

/// A single, reusable sync status indicator (OSDS FR-OSDS-027),
/// available for placement on any screen — 5.6 FR-MOB-007. Backed by a
/// live Drift stream query via Riverpod, so it never needs manual
/// refresh logic: it updates the instant the outbox table changes,
/// whether from a user action or a background sync completing.
class SyncStatusWidget extends ConsumerWidget {
  const SyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingCount = ref.watch(_pendingSyncCountProvider);

    return pendingCount.when(
      data: (count) {
        if (count == 0) {
          return _buildChip(context, icon: Icons.cloud_done, label: 'All synced', color: Colors.green);
        }
        return InkWell(
          onTap: () => SyncEngine.instance.syncNow(),
          child: _buildChip(
            context,
            icon: Icons.cloud_upload,
            label: '$count item${count == 1 ? '' : 's'} waiting to sync',
            color: Colors.orange,
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => _buildChip(context, icon: Icons.cloud_off, label: 'Sync status unavailable', color: Colors.grey),
    );
  }

  Widget _buildChip(BuildContext context, {required IconData icon, required String label, required Color color}) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
    );
  }
}
