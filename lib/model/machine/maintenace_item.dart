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

  factory MaintenanceItem.fromConfig(Map<String, dynamic> json) {
    return MaintenanceItem(
      name: json['name'] as String,
      lastChangedHours: json['lastChangedHours'] as int,
      warningHours: json['warningHours'] as int,
      maintenanceHours: json['maintenanceHours'] as int,
    );
  }
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
