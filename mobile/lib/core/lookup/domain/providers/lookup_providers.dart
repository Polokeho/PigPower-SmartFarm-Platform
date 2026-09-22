import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/lookup_repository.dart';

final lookupRepositoryProvider = Provider<LookupRepository>((ref) => LookupRepository());

/// Live district list — feeds FarmerCreateScreen's dropdown. Follows the
/// same StreamProvider-over-Drift-watch pattern as farmerListProvider,
/// so the dropdown updates automatically once refreshFromServer() has
/// populated the cache — no manual reload/setState wiring needed.
final districtListProvider = StreamProvider((ref) {
  return ref.watch(lookupRepositoryProvider).watchTable('district');
});

final pigBreedListProvider = StreamProvider((ref) {
  return ref.watch(lookupRepositoryProvider).watchTable('pig_breed');
});

final vaccineTypeListProvider = StreamProvider((ref) {
  return ref.watch(lookupRepositoryProvider).watchTable('vaccine_type');
});
