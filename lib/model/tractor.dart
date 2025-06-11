import 'package:farmflow/utils/uuid_generator.dart';

class Tractor {
  final String uuid; // UUID
  final String machineUuid; // 関連する機械のUUID
  final bool? plowAttached; // プラウの取り付け状態
  final double? hydraulicPressure; // 油圧圧力
  final double? tirePressureFront; // 前輪のタイヤ圧力
  final double? tirePressureRear; // 後輪のタイヤ圧力
  final DateTime createdAt; //作成日時
  final DateTime updatedAt; // 更新日時

  const Tractor({
    required this.uuid,
    required this.machineUuid,
    this.plowAttached,
    this.hydraulicPressure,
    this.tirePressureFront,
    this.tirePressureRear,
    required this.createdAt,
    required this.updatedAt,
  });

  // ファクトリーコンストラクタ(新規作成)
  factory Tractor.create({
    required String machineUuid,
    bool? plowAttached,
    double? hydraulicPressure,
    double? tirePressureFront,
    double? tirePressureRear,
  }) {
    final now = DateTime.now();
    return Tractor(
      uuid: generateUuid(),
      machineUuid: machineUuid,
      plowAttached: plowAttached,
      hydraulicPressure: hydraulicPressure,
      tirePressureFront: tirePressureFront,
      tirePressureRear: tirePressureRear,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// JSON読込用ファクトリーコンストラクタ
  factory Tractor.fromJson(Map<String, dynamic> json) {
    return Tractor(
      uuid: json['uuid'],
      machineUuid: json['machineUuid'],
      plowAttached: json['plowAttached'] as bool?,
      hydraulicPressure: (json['hydraulicPressure'] as num?)?.toDouble(),
      tirePressureFront: (json['tirePressureFront'] as num?)?.toDouble(),
      tirePressureRear: (json['tirePressureRear'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  //部分変更用copyWithメソッド
  Tractor copyWith({
    String? machineUuid,
    bool? plowAttached,
    double? hydraulicPressure,
    double? tirePressureFront,
    double? tirePressureRear,
    DateTime? updateAt,
  }) {
    return Tractor(
      uuid: uuid,
      machineUuid: machineUuid ?? this.machineUuid,
      plowAttached: plowAttached ?? this.plowAttached,
      hydraulicPressure: hydraulicPressure ?? this.hydraulicPressure,
      tirePressureFront: tirePressureFront ?? this.tirePressureFront,
      tirePressureRear: tirePressureRear ?? this.tirePressureRear,
      createdAt: createdAt,
      updatedAt: updateAt ?? DateTime.now(),
    );
  }

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'machineUuid': machineUuid,
      'plowAttached': plowAttached,
      'hydraulicPressure': hydraulicPressure,
      'tirePressureFront': tirePressureFront,
      'tirePressureRear': tirePressureRear,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
