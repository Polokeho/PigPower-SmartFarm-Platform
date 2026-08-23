class FarmerModel {
  const FarmerModel({
    required this.id,
    required this.name,
    required this.districtCode,
    required this.status,
    required this.syncStatus,
    this.community,
    this.phone,
  });

  final String id; // local id (client_id) or server farmer_number, once synced
  final String name;
  final String districtCode;
  final String status;
  final String syncStatus; // PENDING_SYNC | SYNCING | SYNCED | REJECTED
  final String? community;
  final String? phone;
}
