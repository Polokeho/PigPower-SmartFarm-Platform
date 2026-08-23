import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/production_batch_model.dart';
import '../../data/repositories/production_repository.dart';

final productionRepositoryProvider = Provider<ProductionRepository>((ref) => ProductionRepository());

final productionListProvider = StreamProvider<List<ProductionBatchModel>>((ref) {
  return ref.watch(productionRepositoryProvider).watchBatches();
});
