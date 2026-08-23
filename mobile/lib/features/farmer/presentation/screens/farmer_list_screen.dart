import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/farmer_providers.dart';
import '../../../../core/widgets/sync_status_widget.dart';

class FarmerListScreen extends ConsumerWidget {
  const FarmerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmersAsync = ref.watch(farmerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmers'),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: Center(child: SyncStatusWidget()))],
      ),
      body: farmersAsync.when(
        data: (farmers) {
          if (farmers.isEmpty) {
            return const Center(child: Text('No farmers yet. Tap + to onboard one.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(farmerRepositoryProvider).refreshFromServer(),
            child: ListView.separated(
              itemCount: farmers.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final farmer = farmers[index];
                return ListTile(
                  title: Text(farmer.name),
                  subtitle: Text('${farmer.districtCode} · ${farmer.status}'),
                  trailing: farmer.syncStatus == 'SYNCED'
                      ? const Icon(Icons.cloud_done, color: Colors.green, size: 18)
                      : farmer.syncStatus == 'REJECTED'
                          ? const Icon(Icons.error_outline, color: Colors.red, size: 18)
                          : const Icon(Icons.cloud_upload, color: Colors.orange, size: 18),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        // 5.6 FR-MOB-011 — this screen is offline-classified "Full
        // Offline" (reads from local cache), so an error here would
        // only ever come from a local database issue, not connectivity.
        error: (err, _) => Center(child: Text('Something went wrong loading farmers.\n$err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/farmers/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
