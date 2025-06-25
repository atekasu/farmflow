import 'package:farmflow/data/dummy/dummy_machines.dart';
import 'package:farmflow/data/dummy/dummy_statuses.dart';
import 'package:farmflow/data/dummy/dummy_tractors.dart';
import 'package:farmflow/data/models/machine_detail_data.dart';
import 'package:farmflow/data/models/machine_with_status.dart';
import 'package:farmflow/data/services/machine_health_calculator.dart';
import 'package:farmflow/data/services/maintenance_status_generator.dart';
import 'package:farmflow/data/services/attention_items_generator.dart';

/// 機械詳細情報取得サービス
class MachineDetailService {
  /// 特定の機械の詳細情報を取得
  static MachineDetailData? getMachineDetail(String machineUuid) {
    try {
      final machine = DummyMachines.getByUuid(machineUuid);
      if (machine == null) return null;

      final status = DummyStatuses.getByUuid(machine.statusUuid);
      if (status == null) return null;

      final tractor = DummyTractors.getByMachineUuid(machineUuid);
      if (tractor == null) return null;

      return MachineDetailData(
        machine: machine,
        status: status,
        tractor: tractor,
        maintenanceStatus: MaintenanceStatusGenerator.generateMaintenanceStatus(machine),
        attentionItems: AttentionItemsGenerator.generateAttentionItems(machine),
      );
    } catch (e) {
      return null;
    }
  }

  /// 機械とステータスの組み合わせデータを取得
  static List<MachineWithStatus> getMachinesWithStatus() {
    return DummyMachines.all.map((machine) {
      final status = DummyStatuses.getByUuid(machine.statusUuid);
      if (status == null) {
        throw Exception('Status not found for machine: ${machine.uuid}');
      }

      final healthStatus = MachineHealthCalculator.calculateHealthStatus(machine);
      final statusColor = MachineHealthCalculator.getStatusColor(healthStatus);

      return MachineWithStatus(
        machine: machine,
        status: status,
        healthStatus: healthStatus,
        statusColor: statusColor,
      );
    }).toList();
  }
}