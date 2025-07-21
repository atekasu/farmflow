import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

enum MachineStatus {
  normal, //正常
  warning, //警告
  maintenace; // メンテナスが必要

  String get lable {
    switch (this) {
      case MachineStatus.normal:
        return '正常';
      case MachineStatus.warning:
        return '警告';
      case MachineStatus.maintenace:
        return 'メンテナンスが必要';
    }
  }
}

//各メンテナンス項目のステータス
enum MachineMaintenanceStatus {
  norml, //正常
  warning, //警告
  maintenace; //メンテナンスが必要

  String get label {
    switch (this) {
      case MachineMaintenanceStatus.norml:
        return '正常';
      case MachineMaintenanceStatus.warning:
        return '警告';
      case MachineMaintenanceStatus.maintenace:
        return 'メンテナンスが必要';
    }
  }
}

//  各メンテナス項目のステータス
enum MaintenanceItemStatus {
  normal, //正常
  warning, //警告
  maintenace; //メンテナンスが必要

  String get label {
    switch (this) {
      case MaintenanceItemStatus.normal:
        return '正常';
      case MaintenanceItemStatus.warning:
        return '警告';
      case MaintenanceItemStatus.maintenace:
        return 'メンテナンスが必要';
    }
  }
}

class MaintenanceItem {
  final String name; //メンテナンス項目名
  final int lastChangedHours; //前回のメンテナンス時の稼働時間
  final int warningHours; //警告を出す稼働時間
  final int maintenanceHours; //交換までの時間

  const MaintenanceItem({
    required this.name,
    required this.lastChangedHours,
    required this.warningHours,
    required this.maintenanceHours,
  });

  //ステータス計算
  MaintenanceItemStatus getStatus(int currentHours) {
    final hoursSinceChange = currentHours - lastChangedHours;

    if (hoursSinceChange >= maintenanceHours) {
      return MaintenanceItemStatus.maintenace;
    } else if (hoursSinceChange >= warningHours) {
      return MaintenanceItemStatus.warning;
    }
    return MaintenanceItemStatus.normal;
  }

  //次回交換まで後何時間かを計算する
  int getHoursUntiMaintenace(int currentHours) {
    final nextMaintenaceHours = lastChangedHours + maintenanceHours;
    final remaining = nextMaintenaceHours - currentHours;
    return remaining > 0 ? remaining.toInt() : 0; //負の値にならないようにする
  }
}

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
      maintenanceItems: {
        'engineOil': MaintenanceItem(
          name: 'エンジンオイル',
          lastChangedHours: runningHours,
          warningHours: 150,
          maintenanceHours: 200,
        ),
        'oilFilter': MaintenanceItem(
          name: 'オイルフィルター',
          lastChangedHours: runningHours,
          warningHours: 180,
          maintenanceHours: 200,
        ),
        'missionOil': MaintenanceItem(
          name: 'ミッションオイル',
          lastChangedHours: runningHours,
          warningHours: 350,
          maintenanceHours: 400,
        ),
        'airFilter': MaintenanceItem(
          name: 'エアフィルター',
          lastChangedHours: runningHours,
          warningHours: 180,
          maintenanceHours: 200,
        ),
        'grease': MaintenanceItem(
          name: 'グリース',
          lastChangedHours: runningHours,
          warningHours: 45,
          maintenanceHours: 50,
        ),
      },
    );
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
