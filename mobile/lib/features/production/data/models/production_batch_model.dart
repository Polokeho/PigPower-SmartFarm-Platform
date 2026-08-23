class ProductionBatchModel {
  const ProductionBatchModel({
    required this.id,
    required this.farmId,
    required this.pigIds,
    required this.recordedAt,
    required this.status,
    required this.syncStatus,
    this.weightKg,
    this.notes,
  });

  final String id;
  final String farmId;
  final List<String> pigIds;
  final DateTime recordedAt;
  final String status;
  final String syncStatus;
  final double? weightKg;
  final String? notes;
}
