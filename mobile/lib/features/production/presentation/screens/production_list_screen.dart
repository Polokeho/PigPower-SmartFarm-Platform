import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/providers/production_providers.dart';
import '../../../../core/widgets/sync_status_widget.dart';

class ProductionListScreen extends ConsumerWidget {
  const ProductionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchesAsync = ref.watch(productionListProvider);
    final dateFormat = DateFormat('d MMM, HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Production'),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: Center(child: SyncStatusWidget()))],
      ),
      body: batchesAsync.when(
        data: (batches) {
          if (batches.isEmpty) {
            return const Center(child: Text('No production entries yet. Tap + to record one.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(productionRepositoryProvider).refreshFromServer(),
            child: ListView.separated(
              itemCount: batches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final batch = batches[index];
                return ListTile(
                  title: Text('${batch.pigIds.length} pig(s) — ${batch.weightKg != null ? '${batch.weightKg} kg' : 'no weight recorded'}'),
                  subtitle: Text('${dateFormat.format(batch.recordedAt)} · ${batch.status}'),
                  trailing: batch.syncStatus == 'SYNCED'
                      ? const Icon(Icons.cloud_done, color: Colors.green, size: 18)
                      : batch.syncStatus == 'REJECTED'
                          ? const Icon(Icons.error_outline, color: Colors.red, size: 18)
                          : const Icon(Icons.cloud_upload, color: Colors.orange, size: 18),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Something went wrong loading production records.\n$err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/production/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
