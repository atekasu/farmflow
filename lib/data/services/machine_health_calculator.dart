import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';

/// 機械の健康状態計算サービス
class MachineHealthCalculator {
  /// 機械の健康状態を計算（稼働時間に基づく）
  /// 1900h未満: 要点検が必要
  /// 2000h未満: 要修理が必要
  /// その他: 良好
  static String calculateHealthStatus(Machine machine) {
    if (machine.runningHours < 1900) return '要点検が必要';
    if (machine.runningHours < 2000) return '要修理が必要';
    return '良好';
  }

  /// 機械の健康状態に応じた色を取得
  static Color getStatusColor(String status) {
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
}