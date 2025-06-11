import 'package:farmflow/utils/uuid_generator.dart';

//機会タイプ別の管理レベル
enum MachineType {
  tractor('トラクター', MaintenaceLevel.detailed),
  combiner('コンバイン', MaintenaceLevel.simple),
  ricePlanter('田植え機', MaintenaceLevel.simple),
  cultivator('管理機', MaintenaceLevel.simple),
  attachment('アタッチメント', MaintenaceLevel.minimal);

  const MachineType(this.displayName, this.maintenanceLevel);
  final String displayName;
  final MaintenaceLevel maintenanceLevel;
}

///メンテナンス管理
enum MaintenaceLevel {
  detailed, // 詳細なメンテナンス
  simple, // 簡易なメンテナンス
  minimal, // 最小限のメンテナンス
}

//農業機械の基本情報クラス
class Machine {
  Machine({
    required this.uuid,
    required this.statusUuid,
    required this.modelName,
    required this.machineType,
    required this.runningHours,
    required this.createdAt,
    required this.updatedAt,
  });

  //ファクトリーコンストラクタ(新規作成)
  factory Machine.create({
    required String statusUuid,
    required String modelName,
    required MachineType machineType,
    int runningHours = 0,
  }) {
    final now = DateTime.now();

    return Machine(
      uuid: generateUuid(),
      statusUuid: statusUuid,
      modelName: modelName,
      machineType: machineType,
      runningHours: runningHours,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// JSON読み込み用ファクトリーコンストラクタ
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      uuid: json['uuid'],
      statusUuid: json['statusUuid'],
      modelName: json['modelName'],
      machineType: MachineType.values.firstWhere(
        (type) => type.name == json['machineType'],
      ),
      runningHours: json['runningHours'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  final String uuid;
  final String statusUuid;
  final String modelName;
  final MachineType machineType;
  final int runningHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  //この機会がどのレベルのメンテナンス管理を必要とするか
  MaintenaceLevel get maintenaceLevel => machineType.maintenanceLevel;
  //コピーコンストラクタ
  Machine copyWith({
    String? statusUuid,
    String? modelName,
    MachineType? machineType,
    DateTime? updatedAt,
  }) {
    return Machine(
      uuid: uuid,
      statusUuid: statusUuid ?? this.statusUuid,
      modelName: modelName ?? this.modelName,
      machineType: machineType ?? this.machineType,
      runningHours: runningHours,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'statusUuid': statusUuid,
      'modelName': modelName,
      'machineType': machineType.name,
      'runningHours': runningHours,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
