import 'package:farmflow/utils/uuid_generator.dart';
import 'package:farmflow/model/enums/maintenance_type.dart';

/// メンテナンス記録クラス（詳細管理用）
class MaintenanceRecord {
  final String uuid;
  final String machineUuid; // 関連する機械のUUID
  final MaintenanceType maintenanceType; // メンテナンスの種類
  final DateTime performedAt; // メンテナンス実施日時
  final int performedHours; // メンテナンス実施時の稼働時間
  final String? notes; // メンテナンスに関する備考
  final double? cost; // メンテナンスにかかった費用
  final String? performedBy; // メンテナンスを実施した人の名前
  final DateTime createdAt;

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

  /// ファクトリーコンストラクタ(新規作成)
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
        orElse: () => MaintenanceType.engineOil,
      ),
      performedAt: DateTime.parse(json['performedAt']),
      performedHours: json['performedHours'] as int? ?? 0,
      notes: json['notes'] as String?,
      cost: (json['cost'] as num?)?.toDouble(),
      performedBy: json['performedBy'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

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