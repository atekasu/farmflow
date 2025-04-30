import 'package:farmflow/models/maintenace/inspection_item.dart';

abstract class MachineType {
  String get name;
  List<InspectionItem> get inspectionItems;
  int get recommendedOilchangeinterval;
          
}
