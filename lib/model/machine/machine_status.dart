import 'package:flutter/material.dart';

enum MachineStatus {
  normal, //正常
  warning, //警告
  maintenance; //メンテナスが必要

  String get label {
    switch (this) {
      case MachineStatus.normal:
        return '正常';
      case MachineStatus.warning:
        return '警告';
      case MachineStatus.maintenance:
        return 'メンテナンスが必要';
    }
  }

  //色を管理
  Color get color {
    switch (this) {
      case MachineStatus.normal:
        return Colors.green;
      case MachineStatus.warning:
        return Colors.orange;
      case MachineStatus.maintenance:
        return Colors.red;
    }
  }

  //アイコンを管理
  IconData get icon {
    switch (this) {
      case MachineStatus.normal:
        return Icons.check_circle;
      case MachineStatus.warning:
        return Icons.warning;
      case MachineStatus.maintenance:
        return Icons.build;
    }
  }
}
