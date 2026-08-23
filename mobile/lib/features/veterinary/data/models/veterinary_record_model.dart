class VeterinaryRecordModel {
  const VeterinaryRecordModel({
    required this.id,
    required this.pigId,
    required this.type,
    required this.administeredAt,
    required this.syncStatus,
    this.vaccineTypeCode,
    this.notes,
  });

  final String id;
  final String pigId;
  final String type; // VACCINATION | TREATMENT | VISIT
  final DateTime administeredAt;
  final String syncStatus; // PENDING_SYNC | SYNCING | SYNCED | REJECTED
  final String? vaccineTypeCode;
  final String? notes;
}
