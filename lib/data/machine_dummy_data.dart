import 'package:flutter/material.dart';
import 'package:farmflow/model/machine.dart';
import 'package:farmflow/model/status.dart';
import 'package:farmflow/model/tractor.dart';

class MachineDummyData {
  static final List<Status> _dummyStatuses = [
    Status.create(name: 'SL400', no: 'No.1', entityType: 'machine'),
    Status.create(name: 'SL400', no: 'No.2', entityType: 'machine'),
    Status.create(name: 'SL400', no: 'No.3', entityType: 'machine'),
    Status.create(name: 'SL500', no: 'No.4', entityType: 'machine'),
    Status.create(name: 'SL500', no: 'No.5', entityType: 'machine'),
    Status.create(name: 'SL550', no: 'No.6 ', entityType: 'machine'),
    Status.create(name: 'MR700', no: 'No.7', entityType: 'machine'),
    Status.create(name: 'SL600', no: 'No.8', entityType: 'machine'),
  ];

  static final List<Machine> _dummyMachines = [
    Machine.create(
      statusUuid: _dummyStatuses[0].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1880,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[1].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1200,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[2].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1500,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[3].uuid,
      modelName: 'SL500',
      machineType: MachineType.tractor,
      runningHours: 2000,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[4].uuid,
      modelName: 'SL500',
      machineType: MachineType.tractor,
      runningHours: 1800,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[5].uuid,
      modelName: 'SL550',
      machineType: MachineType.tractor,
      runningHours: 1600,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[6].uuid,
      modelName: 'MR700',
      machineType: MachineType.combine,
      runningHours: 2200,
    ),
    Machine.create(
      statusUuid: _dummyStatuses[7].uuid,
      modelName: 'SL600',
      machineType: MachineType.tractor,
      runningHours: 1400,
    ),
  ];
  //トラクター詳細のダミーデータ
  static final List<Tractor> _dummyTractors =
      _dummyMachines.map((machine) {
        return Tractor.create(
          machineUuid: machine.uuid,
          plowAttached: false,
          hydraulicPressure: 150.0,
          tirePressureFront: 1.2,
          tirePressureRear: 1.5,
        );
      }).toList();

  //機会一覧取得(ステータス情報も含む)
  static List<MachineWithStatus> getMachinesWithStatus() {
    final List<MachineWithStatus> machinesWithStatus = [];

    for (int i = 0; i < _dummyMachines.length; i++) {
      final machine = _dummyMachines[i];
      final status = _dummyStatuses.firstWhere(
        (s) => s.uuid == machine.statusUuid,
      );

      machinesWithStatus.add(
        MachineWithStatus(
          machine: machine,
          status: status,
          healthStatus: _calculateHealthStatus(machine),
          statusColor: _getStatusColor(_calculateHealthStatus(machine)),
        ),
      );
    }
    return machinesWithStatus;
  }

  ///特定の機械の詳細情報を取得
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

  ///フィルタリングされた機械一覧を取得
  static List<MachineWithStatus> getFilteredMachines(String filter) {
    final allMachine = getMachinesWithStatus();

    if (filter == '全て') return allMachine;
    return allMachine.where((m) => m.healthStatus == filter).toList();
  }

  ///機械の健康状態を計算
  static String _calculateHealthStatus(Machine machine) {
    if (machine.runningHours < 2000) return '要修理が必要';
    if (machine.runningHours < 1900) return '要点検が必要';
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

  //メンテナンス状況のダミーデータ生成
  static List<MaintenanceStatusItem> _generateMaintenanceStatus(
    Machine machine,
  ) {
    return [
      MaintenanceStatusItem(
        type: 'エンジンオイル',
        icon: Icons.oil_barrel,
        iconColor: const Color(0xFF2196F3),
        subtitle: '推奨交換:200h',
        status: '交換から 80h',
        statusColor: Colors.green,
        progressValue: 0.4,
        showProgress: true,
      ),
      MaintenanceStatusItem(
        type: 'ミッションオイル',
        icon: Icons.oil_barrel,
        iconColor: const Color(0xFF2196F3),
        subtitle: '推奨交換:200h',
        status: '交換から 80h',
        statusColor: Colors.green,
        progressValue: 0.4,
        showProgress: true,
      ),
      MaintenanceStatusItem(
        type: '冷却水',
        icon: Icons.water_drop,
        iconColor: const Color(0xFF03A9F4),
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
        iconColor: const Color(0xFF2196F3),
        subtitle: '',
        status: '点検日 2025/04/22',
        statusColor: Colors.grey,
        progressValue: 0.0,
        showProgress: false,
      ),
    ];
  }

  static List<AttentionItem> _generateAttentionItems(Machine machine) {
    if (machine.runningHours < 1900) {
      return [
        AttentionItem(
          title: 'ブレーキ',
          description: 'ブレーキの点検が必要です。',
          icon: Icons.warning,
          priority: 'warning',
        ),
      ];
    }
    return [];
  }
}

///機会とステータスの組み合わせクラス
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

///メンテナンス状況項目クラス
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

///注意事項項目クラス
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

///機会とステータスの組み合わせクラス
