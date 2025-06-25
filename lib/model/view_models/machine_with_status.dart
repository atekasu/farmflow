import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/entities/status.dart';

/// 機会とステータスの組み合わせクラス
class MachineWithStatus {
  final Machine machine;
  final Status status;
  final String healthStatus;
  final Color statusColor;

  const MachineWithStatus({
    required this.machine,
    required this.status,
    required this.healthStatus,
    required this.statusColor,
  });

  ///表示用の機械名の取得
  String get displayName => '${status.no}:${machine.modelName}';

  /// 労働時間の表示文字列
  String get runningHoursDisplay => '${machine.runningHours}h';

  ///健康状態が危険かどうか
  bool get isDangerrous => healthStatus == '要修理が必要';

  ///注意が必要かどうか
  bool get needsAttention => healthStatus == '用点検が必要';
}
