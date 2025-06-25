import 'package:farmflow/'
///フィルタリングされた機械一覧を取得
  class List<MachineWithStatus> getFilteredMachines(String filter) {
    final allMachine = getMachinesWithStatus();

    if (filter == '全て') return allMachine;
    return allMachine.where((m) => m.healthStatus == filter).toList();
  }