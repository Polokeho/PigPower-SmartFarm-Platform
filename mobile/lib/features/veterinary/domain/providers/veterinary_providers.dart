import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/veterinary_record_model.dart';
import '../../data/repositories/veterinary_repository.dart';

final veterinaryRepositoryProvider = Provider<VeterinaryRepository>((ref) => VeterinaryRepository());

final veterinaryListProvider = StreamProvider<List<VeterinaryRecordModel>>((ref) {
  return ref.watch(veterinaryRepositoryProvider).watchRecords();
});
