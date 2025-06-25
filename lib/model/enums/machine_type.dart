import 'package:farmflow/model/enums/maintenance_level.dart';

/// 機械タイプ別の管理レベル
enum MachineType {
  tractor('トラクター', MaintenanceLevel.detailed),
  combine('コンバイン', MaintenanceLevel.simple),
  planter('田植え機', MaintenanceLevel.simple),
  cultivator('管理機', MaintenanceLevel.simple),
  attachment('アタッチメント', MaintenanceLevel.minimal);

  const MachineType(this.displayName, this.maintenanceLevel);
  final String displayName;
  final MaintenanceLevel maintenanceLevel;
}