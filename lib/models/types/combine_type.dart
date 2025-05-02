import 'package:farmflow/models/maintenace/inspection_item.dart';
import 'package:farmflow/models/types/machine_type.dart';

class CombineType implements MachineType {
  @override
  final String name;
  final bool needsUrea; // 尿素が必要かどうか

  @override
  List<InspectionItem> get inspectionItems => [
    InspectionItem(
      name: 'オイル交換',
      description: 'エンジンオイルの交換',
      intervalHours: 150,
    ),
    InspectionItem(
      name: 'エアフィルター',
      description: 'エアフィルターの交換',
      intervalHours: 200,
    ),
    InspectionItem(
      name: 'フィルター交換',
      description: 'エアフィルターの交換',
      intervalHours: 200,
    ),
    if (needsUrea)
      InspectionItem(name: '尿素補充', description: '尿素の補充と確認', intervalHours: 50),
    InspectionItem(name: 'チェーン類', description: '損傷と針の確認', intervalHours: 100),
    InspectionItem(name: '送り菅', description: 'つまりと損傷の確認', intervalHours: 100),
  ];
  @override
  int get recommendedOilchangeinterval => 200; // 推奨オイル交換間隔
  CombineType({required this.name, this.needsUrea = false});
}
