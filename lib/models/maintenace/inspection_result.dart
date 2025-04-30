enum MaintenanceStatus {
  good, //異常なし（緑）
  warning, //そろそろ交換（黄）
  critical, //異常（赤）
}

class InspectionResult {
  final String itemName;
  final bool isCheced;
  final MaintenanceStatus status;
  final DateTime? inspectionDate;
  final String? note;

  InspectionResult({
    required this.itemName,
    required this.isCheced,
    required this.status,
    this.inspectionDate,
    this.note,
  });
}
