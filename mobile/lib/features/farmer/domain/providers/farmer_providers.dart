import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/farmer_model.dart';
import '../../data/repositories/farmer_repository.dart';

final farmerRepositoryProvider = Provider<FarmerRepository>((ref) => FarmerRepository());

/// Live local farmer list — updates automatically as local data changes
/// (via Drift's watch stream), whether from user action or background
/// sync. This is the pattern referenced throughout 5.6 as the reason
/// Riverpod + Drift were chosen together (AD-MOB-001 rationale).
final farmerListProvider = StreamProvider<List<FarmerModel>>((ref) {
  return ref.watch(farmerRepositoryProvider).watchFarmers();
});
