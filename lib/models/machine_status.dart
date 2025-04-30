class MachineStatus {
  final int totalHours;
  final DateTime lastMaintenace;
  final int hoursAtLastOilChange;
  final int hoursAtLastFilterChange;
  final Map<String, bool> checkedItems;
  MachineStatus({
    required this.totalHours,
    required this.lastMaintenace,
    required this.hoursAtLastOilChange,
    required this.hoursAtLastFilterChange,
    required this.checkedItems,
  });
}
