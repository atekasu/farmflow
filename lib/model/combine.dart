import 'package:farmflow/utils/uuid_generator.dart';

/// コンバイン詳細情報クラス（簡易管理）
class Combiner {
  const Combiner({
    required this.uuid,
    required this.machineUuid,
    this.grainTankCapacity,
    this.cuttingWidthCm,
    this.lastJaInspectionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 新規コンバイン詳細作成用ファクトリーコンストラクタ
  factory Combiner.create({
    required String machineUuid,
    int? grainTankCapacity,
    int? cuttingWidthCm,
    DateTime? lastJaInspectionDate,
  }) {
    final now = DateTime.now();
    return Combiner(
      uuid: generateUuid(),
      machineUuid: machineUuid,
      grainTankCapacity: grainTankCapacity,
      cuttingWidthCm: cuttingWidthCm,
      lastJaInspectionDate: lastJaInspectionDate,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// JSON読み込み用ファクトリーコンストラクタ
  factory Combiner.fromJson(Map<String, dynamic> json) {
    return Combiner(
      uuid: json['uuid'],
      machineUuid: json['machineUuid'],
      grainTankCapacity: json['grainTankCapacity'],
      cuttingWidthCm: json['cuttingWidthCm'],
      lastJaInspectionDate:
          json['lastJaInspectionDate'] != null
              ? DateTime.parse(json['lastJaInspectionDate'])
              : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  final String uuid;
  final String machineUuid;
  final int? grainTankCapacity; // グレインタンク容量（L）
  final int? cuttingWidthCm; // 刈り幅（cm）
  final DateTime? lastJaInspectionDate; // 最後のJA点検日
  final DateTime createdAt;
  final DateTime updatedAt;

  /// 次回JA点検の目安（前回から1年後）
  DateTime? get nextJaInspectionDate {
    if (lastJaInspectionDate == null) return null;
    return DateTime(
      lastJaInspectionDate!.year + 1,
      lastJaInspectionDate!.month,
      lastJaInspectionDate!.day,
    );
  }

  /// JA点検が必要かどうか
  bool get needsJaInspection {
    if (lastJaInspectionDate == null) return true;
    final nextDate = nextJaInspectionDate;
    if (nextDate == null) return true;
    return DateTime.now().isAfter(nextDate);
  }

  /// 部分更新用copyWithメソッド
  Combiner copyWith({
    String? machineUuid,
    int? grainTankCapacity,
    int? cuttingWidthCm,
    DateTime? lastJaInspectionDate,
    DateTime? updatedAt,
  }) {
    return Combiner(
      uuid: uuid,
      machineUuid: machineUuid ?? this.machineUuid,
      grainTankCapacity: grainTankCapacity ?? this.grainTankCapacity,
      cuttingWidthCm: cuttingWidthCm ?? this.cuttingWidthCm,
      lastJaInspectionDate: lastJaInspectionDate ?? this.lastJaInspectionDate,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'machineUuid': machineUuid,
      'grainTankCapacity': grainTankCapacity,
      'cuttingWidthCm': cuttingWidthCm,
      'lastJaInspectionDate': lastJaInspectionDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
