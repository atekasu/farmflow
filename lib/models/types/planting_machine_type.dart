import 'package:farmflow/models/types/machine_type.dart';
import 'package:farmflow/models/maintenace/inspection_item.dart';

class PlantingMachineType implements MachineType {
  @override
  final String name;

  @override
  List<InspectionItem> get inspectionItems => [
    InspectionItem(
      name: 'オイル交換',
      description: 'エンジンオイルの交換',
      intervalHours: 150,
    ),
    InspectionItem(name: 'グリス', description: 'グリスの塗布', intervalHours: 50),
  ];
  @override
  int get recommendedOilchangeinterval => 150; // 推奨オイル交換間隔
  PlantingMachineType({required this.name});
}
