import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/entities/status.dart';
import 'package:farmflow/model/entities/tractor.dart';

class MachineDummyData {
  /// メンテナンス状況のダミーデータを生成
  static List<MaintenanceStatusItem> _generateMaintenanceStatus(
    Machine machine,
  ) {
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

  //特定の機械の詳細情報を取得
  static MachineDetailData? getMachineDetail(String machineUuid) {
    try {
      final machine = _dummyMachines.firstWhere(
        (m) => m.uuid == machineUuid,
        orElse: () => throw Exception('machine not found'),
      );
      final status = _dummyStatuses.firstWhere(
        (s) => s.uuid == machine.statusUuid,
      );
      final tractor = _dummyTractors.firstWhere(
        (t) => t.machineUuid == machineUuid,
        orElse: () => throw Exception('tractor not found'),
      );
      return MachineDetailData(
        machine: machine,
        status: status,
        tractor: tractor,
        maintenanceStatus: _generateMaintenanceStatus(machine),
        attentionItems: _generateAttentionItems(machine),
      );
    } catch (e) {
      return null; // 機械が見つからない場合はnullを返す
    }
  }

  /// 機械の健康状態を計算（稼働時間に基づく）
  /// 1900h未満: 要点検が必要
  /// 2000h未満: 要修理が必要
  /// その他: 良好
  static String _calculateHealthStatus(Machine machine) {
    if (machine.runningHours < 1900) return '要点検が必要';
    if (machine.runningHours < 2000) return '要修理が必要';
    return '良好';
  }

  ///機械の健康状態に応じた色を取得
  static Color _getStatusColor(String status) {
    switch (status) {
      case '要修理が必要':
        return Colors.red;
      case '要点検が必要':
        return Colors.orange;
      case '良好':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// 注意事項アイテムを生成（稼働時間に基づく）
}

/// 機械とステータスの組み合わせクラス
class MachineWithStatus {
  final Machine machine;
  final Status status;
  final String healthStatus;
  final Color statusColor;

  MachineWithStatus({
    required this.machine,
    required this.status,
    required this.healthStatus,
    required this.statusColor,
  });
}

/// 機械詳細データクラス（機械、ステータス、トラクター情報を含む）
class MachineDetailData {
  final Machine machine;
  final Status status;
  final Tractor tractor;
  final List<MaintenanceStatusItem> maintenanceStatus;
  final List<AttentionItem> attentionItems;

  MachineDetailData({
    required this.machine,
    required this.status,
    required this.tractor,
    required this.maintenanceStatus,
    required this.attentionItems,
  });
}

/// メンテナンス状況項目クラス
class MaintenanceStatusItem {
  final String type; // メンテナンスの種類
  final IconData icon; // アイコン
  final Color iconColor; // アイコンの色
  final String subtitle; // サブタイトル
  final String status; // 現在のステータス
  final Color statusColor; // ステータスの色
  final double progressValue; // 進捗値（0.0〜1.0）
  final bool showProgress; // 進捗バーを表示するかどうか

  MaintenanceStatusItem({
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.progressValue,
    required this.showProgress,
  });
}

/// 注意事項項目クラス
class AttentionItem {
  final String title; // 注意事項のタイトル
  final String description; // 注意事項の説明
  final IconData icon; // アイコン
  final String priority; // 優先度（例: 'high', 'medium', 'low'）

  AttentionItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.priority,
  });
}
