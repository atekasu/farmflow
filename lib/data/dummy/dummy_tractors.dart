import 'package:farmflow/model/entities/tractor.dart';
import 'package:farmflow/data/dummy/dummy_machines.dart';

class DummyTractors {
  static final List<Tractor> _dummyTractors = DummyMachines.all.map((machine) {
    return Tractor.create(
      machineUuid: machine.uuid,
      plowAttached: false,
      hydraulicPressure: 150.0,
      tirePressureFront: 1.2,
      tirePressureRear: 1.5,
    );
  }).toList();

  static List<Tractor> get all => _dummyTractors;

  static Tractor? getByMachineUuid(String machineUuid) {
    try {
      return _dummyTractors.firstWhere((tractor) => tractor.machineUuid == machineUuid);
    } catch (e) {
      return null;
    }
  }
}
