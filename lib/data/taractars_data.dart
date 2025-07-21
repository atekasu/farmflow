import 'package:farmflow/model/machine/machine.dart';
import 'package:farmflow/model/mantenance.dart';
import 'package:farmflow/model/machine/maintenace_item.dart';

final dummyMachines = [
  Machine(
    id: 't1',
    number: '1号機',
    modelName: 'SL400',
    runningHours: 1250,
    maintenanceItems: {
      'engineOil': MaintenanceItem(
        name: 'エンジンオイル',
        lastChangedHours: 1100, // 150時間前に交換 -> 正常
        warningHours: 150,
        maintenanceHours: 200,
      ),
      'oilFilter': MaintenanceItem(
        name: 'オイルフィルター',
        lastChangedHours: 1050, // 200時間経過 -> 要交換
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'missionOil': MaintenanceItem(
        name: 'ミッションオイル',
        lastChangedHours: 900, // 350時間経過 -> 警告
        warningHours: 350,
        maintenanceHours: 400,
      ),
      'airFilter': MaintenanceItem(
        name: 'エアフィルター',
        lastChangedHours: 1200, // 最近交換 -> 正常
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'grease': MaintenanceItem(
        name: 'グリース給脂',
        lastChangedHours: 1200, // 最近給脂 -> 正常
        warningHours: 45,
        maintenanceHours: 50,
      ),
    },
  ),
  Machine(
    id: 't2',
    number: '2号機',
    modelName: 'FT300',
    runningHours: 2100,
    maintenanceItems: {
      'engineOil': MaintenanceItem(
        name: 'エンジンオイル',
        lastChangedHours: 1950, // 150時間経過 -> 警告
        warningHours: 150,
        maintenanceHours: 200,
      ),
      'oilFilter': MaintenanceItem(
        name: 'オイルフィルター',
        lastChangedHours: 1900, // 200時間経過 -> 要交換
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'missionOil': MaintenanceItem(
        name: 'ミッションオイル',
        lastChangedHours: 1700, // 400時間経過 -> 要交換
        warningHours: 350,
        maintenanceHours: 400,
      ),
      'airFilter': MaintenanceItem(
        name: 'エアフィルター',
        lastChangedHours: 2000,
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'grease': MaintenanceItem(
        name: 'グリース給脂',
        lastChangedHours: 2050, // 50時間経過 -> 要給脂
        warningHours: 45,
        maintenanceHours: 50,
      ),
    },
  ),
  Machine(
    id: 't3',
    number: '3号機',
    modelName: 'SL450',
    runningHours: 890,
    maintenanceItems: {
      'engineOil': MaintenanceItem(
        name: 'エンジンオイル',
        lastChangedHours: 800,
        warningHours: 150,
        maintenanceHours: 200,
      ),
      'oilFilter': MaintenanceItem(
        name: 'オイルフィルター',
        lastChangedHours: 800,
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'missionOil': MaintenanceItem(
        name: 'ミッションオイル',
        lastChangedHours: 500, // 390時間経過 -> 警告
        warningHours: 350,
        maintenanceHours: 400,
      ),
      'airFilter': MaintenanceItem(
        name: 'エアフィルター',
        lastChangedHours: 850,
        warningHours: 180,
        maintenanceHours: 200,
      ),
      'grease': MaintenanceItem(
        name: 'グリース給脂',
        lastChangedHours: 840, // 50時間経過 -> 要給脂
        warningHours: 45,
        maintenanceHours: 50,
      ),
    },
  ),
];

final dummyMaintenanceRecords = [
  MaintenanceRecord(
    id: 'm1',
    machineId: 't1',
    type: MaintenanceType.engineOil,
    date: DateTime.now().subtract(const Duration(days: 15)),
    runningHours: 1200,
    notes: '純正オイル使用',
    nextDueHours: 1350,
  ),
  MaintenanceRecord(
    id: 'm2',
    machineId: 't2',
    type: MaintenanceType.grease,
    date: DateTime.now().subtract(const Duration(days: 45)),
    runningHours: 2050,
    notes: 'フロントアクスル給脂',
    nextDueHours: 2100,
  ),
  MaintenanceRecord(
    id: 'm3',
    machineId: 't3',
    type: MaintenanceType.oilFilter,
    date: DateTime.now().subtract(const Duration(days: 30)),
    runningHours: 800,
    notes: '純正フィルター使用',
    nextDueHours: 1000,
  ),
];
