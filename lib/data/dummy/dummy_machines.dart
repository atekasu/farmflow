import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/enums/machine_type.dart';
import 'package:farmflow/data/dummy/dummy_statuses.dart';

class DummyMachines {
  static final List<Machine> _dummyMachines = [
    Machine.create(
      statusUuid: DummyStatuses.all[0].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1880,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[1].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1200,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[2].uuid,
      modelName: 'SL400',
      machineType: MachineType.tractor,
      runningHours: 1500,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[3].uuid,
      modelName: 'SL500',
      machineType: MachineType.tractor,
      runningHours: 2000,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[4].uuid,
      modelName: 'SL500',
      machineType: MachineType.tractor,
      runningHours: 1800,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[5].uuid,
      modelName: 'SL550',
      machineType: MachineType.tractor,
      runningHours: 1600,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[6].uuid,
      modelName: 'MR700',
      machineType: MachineType.combine,
      runningHours: 2200,
    ),
    Machine.create(
      statusUuid: DummyStatuses.all[7].uuid,
      modelName: 'SL600',
      machineType: MachineType.tractor,
      runningHours: 1400,
    ),
  ];

  static List<Machine> get all => _dummyMachines;

  static Machine? getByUuid(String uuid) {
    try {
      return _dummyMachines.firstWhere((machine) => machine.uuid == uuid);
    } catch (e) {
      return null;
    }
  }
}
