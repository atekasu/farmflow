import 'package:farmflow/utils/uuid_generator.dart';
import 'package:farmflow/model/machine.dart';
import 'package:farmflow/model/machinetype.dart';
import 'package:farmflow/utils/constants.dart';

/// メンテナンス種別（メンテナンスの種類を表す）
enum MaintenanceType {
  engineOil(
    'エンジンオイル交換',
    AppConstants.engineOilRecommended,
    AppConstants.engineOilRequired,
    // constコンテキストでSetリテラルを使用
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),
  oilFilter(
    'オイルフィルター交換',
    AppConstants.oilFilterRecommended,
    AppConstants.oilFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),
  airFilter(
    'エアフィルター交換',
    AppConstants.aireFilterRecommended,
    AppConstants.aireFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),
  missionOil(
    'ミッションオイル交換',
    AppConstants.missionOilRecommended,
    AppConstants.missionOilRequired,
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),
  fuelFilter(
    '燃料フィルター交換',
    AppConstants.fuelFilterRecommended,
    AppConstants.fuelFilterRequired,
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),
  grease(
    'グリスアップ',
    AppConstants.greaceRecommended,
    AppConstants.greaceRequired,
    <MachineType>{MachineType.tractor, MachineType.cultivator},
  ),

  // 簡易管理項目
  preOperationCheck(
    '始業前点検',
    0,
    0,
    // MachineType.valuesは実行時に決まるためconst不可
    // 代わりに全ての値を明示的に列挙
    <MachineType>{
      MachineType.tractor,
      MachineType.cultivator,
      MachineType.combiner,
      MachineType.ricePlanter,
    },
  ),
  dailyInspection(
    '日常点検',
    0,
    0,
    <MachineType>{
      MachineType.tractor,
      MachineType.cultivator,
      MachineType.combiner,
      MachineType.ricePlanter,
    },
  ),
  cleaning(
    '清掃',
    0,
    0,
    <MachineType>{
      MachineType.tractor,
      MachineType.cultivator,
      MachineType.combiner,
      MachineType.ricePlanter,
    },
  ),

  // JA委託メンテナンス
  jaAnnualInspection(
    'JA年次点検',
    0,
    0,
    <MachineType>{
      MachineType.tractor,
      MachineType.cultivator,
      MachineType.combiner,
      MachineType.ricePlanter,
    },
  ),
  jaRepair(
    'JA修理',
    0,
    0,
    <MachineType>{MachineType.combiner, MachineType.ricePlanter},
  ),

  // コンバインの特有始業前点検
  chainOilApplication(
    'チェーンオイル塗布',
    0,
    0,
    <MachineType>{MachineType.combiner},
  ),
  grainTankCleaning(
    'グレインタンク清掃',
    0,
    0,
    <MachineType>{MachineType.combiner},
  );

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

/// メンテナンス記録クラス（詳細管理用）
/// enum外に移動してクラス構造を修正
class MaintenanceRecord {
  MaintenanceRecord({
    required this.uuid,
    required this.machineUuid,
    required this.maintenanceType,
    required this.performedAt,
    required this.performedHours,
    this.notes,
    this.cost,
    this.performedBy,
    required this.createdAt,
  });

  // ファクトリーコンストラクタ(新規作成)
  factory MaintenanceRecord.create({
    required String machineUuid,
    required MaintenanceType maintenanceType,
    required DateTime performedAt,
    required int performedHours,
    String? notes,
    double? cost,
    String? performedBy,
  }) {
    final now = DateTime.now();
    return MaintenanceRecord(
      uuid: generateUuid(),
      machineUuid: machineUuid,
      maintenanceType: maintenanceType,
      performedAt: performedAt,
      performedHours: performedHours,
      notes: notes,
      cost: cost,
      performedBy: performedBy,
      createdAt: now,
    );
  }

  /// JSON読込用ファクトリーコンストラクタ
  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
    return MaintenanceRecord(
      uuid: json['uuid'],
      machineUuid: json['machineUuid'],
      maintenanceType: MaintenanceType.values.firstWhere(
        (type) => type.name == json['maintenanceType'],
        orElse: () => MaintenanceType.engineOil, // typo修正: enginOil → engineOil
      ),
      performedAt: DateTime.parse(json['performedAt']),
      performedHours: json['performedHours'] as int? ?? 0,
      notes: json['notes'] as String?,
      cost: (json['cost'] as num?)?.toDouble(),
      performedBy: json['performedBy'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  final String uuid;
  final String machineUuid; // 関連する機械のUUID
  final MaintenanceType maintenanceType; // メンテナンスの種類
  final DateTime performedAt; // メンテナンス実施日時
  final int performedHours; // メンテナンス実施時の稼働時間
  final String? notes; // メンテナンスに関する備考
  final double? cost; // メンテナンスにかかった費用
  final String? performedBy; // メンテナンスを実施した人の名前
  final DateTime createdAt;

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'machineUuid': machineUuid,
      'maintenanceType': maintenanceType.name,
      'performedAt': performedAt.toIso8601String(),
      'performedHours': performedHours,
      'notes': notes,
      'cost': cost,
      'performedBy': performedBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// 記録のコピーを作成（編集用）
  MaintenanceRecord copyWith({
    String? uuid,
    String? machineUuid,
    MaintenanceType? maintenanceType,
    DateTime? performedAt,
    int? performedHours,
    String? notes,
    double? cost,
    String? performedBy,
    DateTime? createdAt,
  }) {
    return MaintenanceRecord(
      uuid: uuid ?? this.uuid,
      machineUuid: machineUuid ?? this.machineUuid,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      performedAt: performedAt ?? this.performedAt,
      performedHours: performedHours ?? this.performedHours,
      notes: notes ?? this.notes,
      cost: cost ?? this.cost,
      performedBy: performedBy ?? this.performedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}