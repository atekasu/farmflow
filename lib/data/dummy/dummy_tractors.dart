import 'package:farmflow/model/entities/tractor.dart';
import 'package:farmflow/data/dummy/dummy_machines.dart';

/// トラクター詳細のダミーデータ
final List<Tractor> dummyTractors =
    dummyMachines.map((machine) {
      return Tractor.create(
        machineUuid: machine.uuid,
        plowAttached: false,
        hydraulicPressure: 150.0,
        tirePressureFront: 1.2,
        tirePressureRear: 1.5,
      );
    }).toList();
