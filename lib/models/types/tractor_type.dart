import 'package:farmflow/models/types/machine_type.dart';
import 'package:farmflow/models/maintenace/inspection_item.dart';

class TractorType implements MachineType {
  @override
  final String name;

  @override
  List<InspectionItem> get inspectionItems => [
    InspectionItem(
      name: 'エンジンオイル',
      description: '150時間ごとに交換',
      intervalHours: 150,
    ),
    InspectionItem(
      name: 'ミッションオイル',
      description: '200時間ごとに交換',
      intervalHours: 200,
    ),
    InspectionItem(
      name: 'エアフィルター',
      description: '200時間ごとに交換、フィルター清掃',
      intervalHours: 200,
    ),
    InspectionItem(
      name: 'オイルフィルター',
      description: '200時間ごとに交換',
      intervalHours: 200,
    ),
    InspectionItem(
      name: '冷却水', 
      description: '点検', 
      intervalHours: 50),
    InspectionItem(
      name: 'グリス',
      description: '50時間ごとに注油',
      intervalHours: 50,
    ),
    InspectionItem(
      name: 'タイヤ',
      description: '点検',
      intervalHours: 50,
    ),
    //他の点検項目も追加
  ];
  @override
  int get recommendedOilchangeinterval => 150;
  TractorType({required this.name});
}
