import 'package:farmflow/data/models/machine_with_status.dart';
import 'package:farmflow/data/services/machine_detail_service.dart';

/// 機械フィルタリングサービス
class MachineFilterService {
  /// フィルタリングされた機械一覧を取得
  static List<MachineWithStatus> getFilteredMachines(String filter) {
    final allMachines = MachineDetailService.getMachinesWithStatus();

    if (filter == '全て') return allMachines;
    return allMachines.where((m) => m.healthStatus == filter).toList();
  }

  /// 利用可能なフィルター選択肢を取得
  static List<String> getAvailableFilters() {
    return ['全て', '良好', '要点検が必要', '要修理が必要'];
  }
}