import 'package:farmflow/model/enums/machine_type.dart';
import 'package:farmflow/utils/constants.dart';

/// メンテナンス種別（メンテナンスの種類を表す）
enum MaintenanceType {
  engineOil(
    'エンジンオイル交換',
    AppConstants.engineOilRecommended,
    AppConstants.engineOilRequired,
    // constコンテキストでSetリテラルを使用
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),
  oilFilter(
    'オイルフィルター交換',
    AppConstants.oilFilterInterval,
    AppConstants.oilFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),
  airFilter(
    'エアフィルター交換',
    AppConstants.airFilterInterval,
    AppConstants.airFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),
  missionOil(
    'ミッションオイル交換',
    AppConstants.missionOilInterval,
    AppConstants.missionOilRequired,
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),
  fuelFilter(
    '燃料フィルター交換',
    AppConstants.fuelFilterInterval,
    AppConstants.fuelFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),
  grease(
    'グリスアップ',
    AppConstants.greaseInterval,
    AppConstants.greaseRequired,
    <MachineType>{MachineType.tractor, MachineType.planter},
  ),

  // 簡易管理項目
  preOperationCheck(
    '始業前点検',
    0,
    0,
    // 全ての機械タイプを明示的に列挙
    <MachineType>{
      MachineType.tractor,
      MachineType.planter,
      MachineType.combine,
      MachineType.cultivator,
    },
  ),
  dailyInspection('日常点検', 0, 0, <MachineType>{
    MachineType.tractor,
    MachineType.planter,
    MachineType.combine,
    MachineType.cultivator,
  }),
  cleaning('清掃', 0, 0, <MachineType>{
    MachineType.tractor,
    MachineType.planter,
    MachineType.combine,
    MachineType.cultivator,
  }),

  // JA委託メンテナンス
  jaAnnualInspection('JA年次点検', 0, 0, <MachineType>{
    MachineType.tractor,
    MachineType.planter,
    MachineType.combine,
    MachineType.cultivator,
  }),
  jaRepair('JA修理', 0, 0, <MachineType>{
    MachineType.combine,
    MachineType.cultivator,
  }),

  // コンバインの特有始業前点検
  chainOilApplication('チェーンオイル塗布', 0, 0, <MachineType>{MachineType.combine}),
  grainTankCleaning('グレインタンク清掃', 0, 0, <MachineType>{MachineType.combine});

  const MaintenanceType(
    this.displayName,
    this.recommendedInterval,
    this.requiredInterval,
    this.applicableMachineTypes,
  );

  final String displayName; // メンテナンスの表示名
  final int recommendedInterval; // 推奨メンテナンス間隔（時間）
  final int requiredInterval; // 必須メンテナンス間隔（時間）
  final Set<MachineType> applicableMachineTypes;

  /// この機械タイプに適用可能なメンテナンス項目か判断
  bool isApplicableFor(MachineType machineType) {
    return applicableMachineTypes.contains(machineType);
  }

  /// 特定の機械タイプに適用可能なメンテナンス項目の取得
  static List<MaintenanceType> getApplicableTypes(MachineType machineType) {
    return MaintenanceType.values
        .where((type) => type.isApplicableFor(machineType))
        .toList();
  }

  /// 推奨期限切れかどうかの判断
  bool isRecommendedOverdue(int currentHours, int? lastMaintenanceHours) {
    if (recommendedInterval == 0) return false;
    if (lastMaintenanceHours == null) return true;
    return (currentHours - lastMaintenanceHours) >= recommendedInterval;
  }

  /// 必須期限切れかどうかの判断
  bool isRequiredOverdue(int currentHours, int? lastMaintenanceHours) {
    if (requiredInterval == 0) return false;
    if (lastMaintenanceHours == null) return true;
    return (currentHours - lastMaintenanceHours) >= requiredInterval;
  }
}