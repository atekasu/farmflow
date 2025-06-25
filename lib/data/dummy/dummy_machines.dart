import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/enums/machine_type.dart';
import 'package:farmflow/data/dummy/dummy_statuses.dart';

final List<Machine> dummyMachines = [
  Machine.create(
    statusUuid: dummyStatuses[0].uuid,
    modelName: 'SL400',
    machineType: MachineType.tractor,
    runningHours: 1880,
  ),
  Machine.create(
    statusUuid: dummyStatuses[1].uuid,
    modelName: 'SL400',
    machineType: MachineType.tractor,
    runningHours: 1200,
  ),
  Machine.create(
    statusUuid: dummyStatuses[2].uuid,
    modelName: 'SL400',
    machineType: MachineType.tractor,
    runningHours: 1500,
  ),
  Machine.create(
    statusUuid: dummyStatuses[3].uuid,
    modelName: 'SL500',
    machineType: MachineType.tractor,
    runningHours: 2000,
  ),
  Machine.create(
    statusUuid: dummyStatuses[4].uuid,
    modelName: 'SL500',
    machineType: MachineType.tractor,
    runningHours: 1800,
  ),
  Machine.create(
    statusUuid: dummyStatuses[5].uuid,
    modelName: 'SL550',
    machineType: MachineType.tractor,
    runningHours: 1600,
  ),
  Machine.create(
    statusUuid: dummyStatuses[6].uuid,
    modelName: 'MR700',
    machineType: MachineType.combine,
    runningHours: 2200,
  ),
  Machine.create(
    statusUuid: dummyStatuses[7].uuid,
    modelName: 'SL600',
    machineType: MachineType.tractor,
    runningHours: 1400,
  ),
];
