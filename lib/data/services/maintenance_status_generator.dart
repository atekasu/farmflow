import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/data/models/maintenance_status_item.dart';

/// メンテナンス状況データ生成サービス
class MaintenanceStatusGenerator {
  /// メンテナンス状況のダミーデータを生成
  static List<MaintenanceStatusItem> generateMaintenanceStatus(Machine machine) {
    return [
      MaintenanceStatusItem(
        type: 'エンジンオイル',
        icon: Icons.oil_barrel,
        iconColor: Colors.blue,
        subtitle: '推奨交換:200h',
        status: '交換から 80h',
        statusColor: Colors.green,
        progressValue: 0.4,
        showProgress: true,
      ),
      MaintenanceStatusItem(
        type: 'ミッションオイル',
        icon: Icons.oil_barrel,
        iconColor: Colors.blue,
        subtitle: '推奨交換:200h',
        status: '交換から 80h',
        statusColor: Colors.green,
        progressValue: 0.4,
        showProgress: true,
      ),
      MaintenanceStatusItem(
        type: '冷却水',
        icon: Icons.water_drop,
        iconColor: Colors.lightBlue,
        subtitle: '',
        status: '点検日 2025/04/22',
        statusColor: Colors.grey,
        progressValue: 0.0,
        showProgress: false,
      ),
      MaintenanceStatusItem(
        type: 'グリース',
        icon: Icons.construction,
        iconColor: Colors.grey,
        subtitle: '',
        status: '点検日 2025/04/22',
        statusColor: Colors.grey,
        progressValue: 0.0,
        showProgress: false,
      ),
      MaintenanceStatusItem(
        type: 'エアフィルター',
        icon: Icons.air,
        iconColor: Colors.blue,
        subtitle: '',
        status: '点検日 2025/04/22',
        statusColor: Colors.grey,
        progressValue: 0.0,
        showProgress: false,
      ),
    ];
  }
}