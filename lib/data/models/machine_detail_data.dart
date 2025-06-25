import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/model/entities/status.dart';
import 'package:farmflow/model/entities/tractor.dart';
import 'package:farmflow/data/models/maintenance_status_item.dart';
import 'package:farmflow/data/models/attention_item.dart';

/// 機械詳細データクラス（機械、ステータス、トラクター情報を含む）
class MachineDetailData {
  final Machine machine;
  final Status status;
  final Tractor tractor;
  final List<MaintenanceStatusItem> maintenanceStatus;
  final List<AttentionItem> attentionItems;

  MachineDetailData({
    required this.machine,
    required this.status,
    required this.tractor,
    required this.maintenanceStatus,
    required this.attentionItems,
  });
}