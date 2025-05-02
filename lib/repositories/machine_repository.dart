import 'package:farmflow/models/machine.dart';
import 'package:farmflow/models/machine_status.dart';

abstract class MachineRepository {
  Future<List<Machine>> getAllMachines();
  Future<Machine?> getMachineById(String id);
  Future<void> saveMachine(Machine machine);
  Future<void> updateMachineStatus(String id, MachineStatus newStatus);
  Future<void> deleteMachine(String id);
}
