import 'package:uuid/uuid.dart';
import 'package:farmflow/model/machine/maintenance_constants.dart';
import 'package:farmflow/model/machine/machine_status.dart';
import 'package:farmflow/model/machine/maintenace_item.dart';

class Machine {
  final String id;
  final String number;
  final String modelName;
  final int runningHours;
  final Map<String, MaintenanceItem> maintenanceItems;

  const Machine({
    required this.id,
    required this.number,
    required this.modelName,
    required this.runningHours,
    required this.maintenanceItems,
  });

  //新規制作用(ID自動生成)
  factory Machine.create({
    required String number,
    required String modelName,
    required int runningHours,
  }) {
    return Machine(
      id: const Uuid().v4(),
      number: number,
      modelName: modelName,
      runningHours: runningHours,
      maintenanceItems: _createStandardMaintenanceItems(runningHours),
    );
  }
  //標準的なメンテナンス項目を作成する
  static Map<String, MaintenanceItem> _createStandardMaintenanceItems(
    int runningHours,
  ) {
    final items = <String, MaintenanceItem>{};

    for (final entry in MaintenanceConfig.standardItems.entries) {
      items[entry.key] = MaintenanceItem.fromConfig(entry.value.toJson());
    }

    return items;
  }

  //全体のステータス判定
  MachineStatus get overallStatus {
    bool hasWarning = false;
    bool hasMaintenace = false;

    for (final item in maintenanceItems.values) {
      final status = item.getStatus(runningHours);
      if (status == MaintenanceItemStatus.maintenace) {
        hasMaintenace = true;
      } else if (status == MaintenanceItemStatus.warning) {
        hasWarning = true;
      }
    }
    if (hasMaintenace) {
      return MachineStatus.maintenace;
    } else if (hasWarning) {
      return MachineStatus.warning;
    }
    return MachineStatus.normal;
  }

  //各項目のステータスを取得する
  Map<String, MaintenanceItemStatus> get itemStatuses {
    return maintenanceItems.map(
      (key, item) => MapEntry(key, item.getStatus(runningHours)),
    );
  }

  //要注意時項目のリストを取得する
  List<MaintenanceItem> get warningItems {
    return maintenanceItems.entries
        .where(
          (entry) =>
              entry.value.getStatus(runningHours) ==
              MaintenanceItemStatus.warning,
        )
        .map((entry) => entry.value)
        .toList();
  }

  //メンテナンス必須項目のリストを取得する
  List<MaintenanceItem> get maintenanceRequiredItems {
    return maintenanceItems.entries
        .where(
          (entry) =>
              entry.value.getStatus(runningHours) ==
              MaintenanceItemStatus.maintenace,
        )
        .map((entry) => entry.value)
        .toList();
  }

  //Firebace用のデータ変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'modelName': modelName,
      'runningHours': runningHours,
      'maintenanceItems': maintenanceItems.map(
        (key, item) => MapEntry(key, {
          'name': item.name,
          'lastChangedHours': item.lastChangedHours,
          'warningHours': item.warningHours,
          'maintenanceHours': item.maintenanceHours,
        }),
      ),
    };
  }

  //Firebaseからのデータ作成用
  factory Machine.fromJson(Map<String, dynamic> json) {
    final maintenaceItemsData =
        json['maintenanceItems'] as Map<String, dynamic>;
    final maintenaceItems = <String, MaintenanceItem>{};

    maintenaceItemsData.forEach((key, value) {
      maintenaceItems[key] = MaintenanceItem(
        name: value['name'] as String,
        lastChangedHours: value['lastChangedHours'] as int,
        warningHours: value['warningHours'] as int,
        maintenanceHours: value['maintenanceHours'] as int,
      );
    });

    return Machine(
      id: json['id'] as String,
      number: json['number'] as String,
      modelName: json['modelName'] as String,
      runningHours: json['runningHours'] as int,
      maintenanceItems: maintenaceItems,
    );
  }

  //編集用処理
  Machine copyWith({
    String? id,
    String? number,
    String? modelName,
    int? runningHours,
    Map<String, MaintenanceItem>? maintenanceItems,
  }) {
    return Machine(
      id: id ?? this.id,
      number: number ?? this.number,
      modelName: modelName ?? this.modelName,
      runningHours: runningHours ?? this.runningHours,
      maintenanceItems: maintenanceItems ?? this.maintenanceItems,
    );
  }
}
