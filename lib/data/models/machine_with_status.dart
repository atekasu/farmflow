import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/entities/status.dart';

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