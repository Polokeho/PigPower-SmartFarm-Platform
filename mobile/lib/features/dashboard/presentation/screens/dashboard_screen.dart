import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../../core/widgets/sync_status_widget.dart';

/// A single dashboard whose CONTENT varies by role, rather than
/// separate screens/apps per role — 5.6 AD-SYS-003 / FR-MOB-003.
/// Pass 1 shows the three feature areas built so far (Farmer,
/// Production, Veterinary); each new module pass adds its own tile
/// here, gated by permission.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${auth.username ?? ''}'),
        actions: [
          const Padding(padding: EdgeInsets.only(right: 8), child: Center(child: SyncStatusWidget())),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: [
          if (auth.hasPermission('farmer.view'))
            _DashboardTile(icon: Icons.people, label: 'Farmers', onTap: () => context.push('/farmers')),
          if (auth.hasPermission('production.view'))
            _DashboardTile(icon: Icons.agriculture, label: 'Production', onTap: () => context.push('/production')),
          if (auth.hasPermission('veterinary.view'))
            _DashboardTile(icon: Icons.medical_services, label: 'Veterinary', onTap: () => context.push('/veterinary')),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  const _DashboardTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
