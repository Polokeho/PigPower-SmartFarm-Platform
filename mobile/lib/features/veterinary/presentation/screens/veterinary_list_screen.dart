import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/providers/veterinary_providers.dart';
import '../../../../core/widgets/sync_status_widget.dart';

class VeterinaryListScreen extends ConsumerWidget {
  const VeterinaryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(veterinaryListProvider);
    final dateFormat = DateFormat('d MMM, HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinary'),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: Center(child: SyncStatusWidget()))],
      ),
      body: recordsAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return const Center(child: Text('No veterinary records yet. Tap + to record one.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(veterinaryRepositoryProvider).refreshFromServer(),
            child: ListView.separated(
              itemCount: records.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text('${record.type} — Pig ${record.pigId}'),
                  subtitle: Text(dateFormat.format(record.administeredAt)),
                  trailing: record.syncStatus == 'SYNCED'
                      ? const Icon(Icons.cloud_done, color: Colors.green, size: 18)
                      : record.syncStatus == 'REJECTED'
                          ? const Icon(Icons.error_outline, color: Colors.red, size: 18)
                          : const Icon(Icons.cloud_upload, color: Colors.orange, size: 18),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Something went wrong loading veterinary records.\n$err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/veterinary/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
