import 'package:flutter/material.dart';
import 'package:farmflow/model/machine.dart';
import 'package:farmflow/model/status.dart';
import 'package:farmflow/model/tractor.dart';
import 'package:farmflow/utils/uuid_generator.dart';

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
          statusColor: _getStatusColor(_calculateHealthStatsu(machine)),
        ));
    }
    return machinesWithStatus;
  }


///特定の機械の詳細情報を取得
static MachineDeteilData? getMachineDetail(StringmachineUuid){
  final machine = _dummyMachines.firstWhere(
    (m) => m.uuid == machineUuid,
    orElse:() => throw Exception('manie not found'),
  );
  final status = _dummyStatuses.firstWhere((s) => s.uuid == mahicne.starusUuid,
  );
  final tractor = _dummyTractors.firstWhere((t) => t.machineUuid == machineUuid,
  orElse: () => throw Exception('tractor not found'),
  );
  return MachineDeteilData(
    machine: machine,
    status: status,
    tractor: tractor,
  );
}

///フィルタリングされた機械一覧を取得
static List<MachineWithStatus> getFilteredMachines(Stirng filter){
  final allMachine = getMachinesWithStatus();

  if (filter == '全て')return allMachine;
  return allMachine.where((m) => m.healthStatus == filter).toList();
}

///機械の健康状態を計算
static String _calculateHealthStatus(Machine machine){
  if(machine.runningHours < 2000)return '要修理が必要';
  if(machine.runningHours < 1900)return'用点検が必要';
  return '良好';
}

///機械の健康状態に応じた色を取得
static Color _getStatusColor(String status) {
  switch (status) {
    case '要修理が必要':
      return Colors.red;
    case '用点検が必要':
      return Colors.orange;
    case '良好':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
//メンテナンス状況のダミーデータ生成
static List<MaintenanceStatusItem> _generateMaintenanceStatus(Machine machine){
  return[
    MaintenaceStatusItem(
      type:'エンジンオイル',
      icon: Icons.oil_barrel,
      iconColor:const Color(0xFF2196F3),
      subtitle:'推奨交換:200h',
      status:'交換から 80h',
      statusColor: Colors.gereen,
      progressValue:0.4,
      showProgress: true,
    ),
  ]
}
}
///機会とステータスの組み合わせクラス
class MachineWithStatus{
  
}
///機会とステータスの組み合わせクラス
class MachineWithStatus {
  MachineWithStatus({
    required this.machine,
    required this.status,
    required this.healthStatus,
    required this.statusColor,
  });
  final Machine machine;
  final Status status;
  final String healthStatus;
  final Color statusColor;
}
