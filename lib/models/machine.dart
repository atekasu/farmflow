import 'package:uuid/uuid.dart';

import 'types/machine_type.dart';
import 'package:farmflow/models/machine_status.dart';
import 'maintenace/inspection_result.dart';

class Machine {
  final String id;
  final String uuid;
  final String modelName;
  final MachineType type;
  final MachineStatus status;
  final List<InspectionResult> inspectionHistory;

  Machine({
    required this.id,
    String? uuid,
    required this.modelName,
    required this.type,
    required this.status,
    this.inspectionHistory = const [],
  }) : this.uuid = uuid ?? Uuid().v4();

  MaintenanceStatus calculateMaintenaceStatus() {
    if (type.recommendedOilchangeinterval <= 0) {
      //アタッチメントのメンテナス状態は点検結果に基づく
      final allItems = type.inspectionItems.map((item) => item.name).toList();
      final uncheckedItems =
          allItems.where((name) => !isItemChecked(name)).toList();

      if (uncheckedItems.isNotEmpty) {
        return MaintenanceStatus.warning;
      }

      return MaintenanceStatus.good;
    } else {
      final hoursSinceOilChange =
          status.totalHours - status.hoursAtLastOilChange;

      if (hoursSinceOilChange >= type.recommendedOilchangeinterval) {
        return MaintenanceStatus.critical;
      } else if (hoursSinceOilChange >=
          type.recommendedOilchangeinterval * 0.8) {
        return MaintenanceStatus.warning;
      } else {
        return MaintenanceStatus.good;
      }
    }
  }

  bool isItemChecked(String itemName) {
    return status.checkedItems[itemName] ?? false;
  }

  //最新の点検結果を取得
  InspectionResult? getLatestInspectionResult(String itemName) {
    final results =
        inspectionHistory
            .where((result) => result.itemName == itemName)
            .toList();

    if (results.isEmpty) return null;

    results.sort((a, b) {
      //inspectionDateが新しい順にソート
      if (a.inspectionDate == null && b.inspectionDate == null) return 0;
      if (a.inspectionDate == null) return 1;
      if (b.inspectionDate == null) return -1;
      return (a.inspectionDate!.compareTo(a.inspectionDate!));
    });
    return results.first;
  }

  //ステータスを更新した新しいmachineインスタンスを生成
  Machine copyWithStatus(MachineStatus newStatus) {
    return Machine(
      id: id,
      uuid: uuid,
      modelName: modelName,
      type: type,
      status: newStatus,
      inspectionHistory: inspectionHistory,
    );
  }

  //点検結果を追加したあたらしいMachineインスタンスを生成
  Machine addInspectionResult(InspectionResult result) {
    final newHistory = List<InspectionResult>.from(inspectionHistory)
      ..add(result);

    return Machine(
      id: id,
      uuid: uuid,
      modelName: modelName,
      type: type,
      status: status,
      inspectionHistory: newHistory,
    );
  }
}
