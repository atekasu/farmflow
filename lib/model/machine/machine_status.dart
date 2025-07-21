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
