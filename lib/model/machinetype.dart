import 'package:farmflow/utils/uuid_generator.dart';

enum MachineType {
  tractor('トラクター', MaintenanceLevel.detailed),
  combine('コンバイン', MaintenanceLevel.simple),
  cultivator('田植え機', MaintenanceLevel.simple),
  planter('管理機', MaintenanceLevel.detailed),
  sallMachine('アタッチメント', MaintenanceLevel.minimal);

  const MachineType(this.displayName, this.maintenanceLevel);

  final String displayName;
  final MaintenanceLevel maintenanceLevel;
}

enum MaintenanceLevel {
  detailed, //詳細なメンテナンス管理（個人で実施）
  simple, //簡易的な記録（JAにメンテナンス委託、作業記録中心）
  minimal, //最小限の記録(アタッチメント等)
}

class Machine {
  const Machine({
    required this.uuid,
    required this.statusUuid,
    required this.modelname,
    required this.machineType,
    required this.runnningHours,
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
      modelname: modelName,
      machineType: machineType,
      runnningHours: runningHours,
      createdAt: now,
      updatedAt: now,
    );
  }

  ///JSON読込用ファクトリーコンストラクタ
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      uuid: json['uuid'],
      statusUuid: json['statusUuid'],
      modelname: json['modelname'],
      machineType: MachineType.values.firstWhere(
        (type) => type.name == json['machineTyep'],
        orElse: () => MachineType.tractor,
      ),
      runnningHours: json['runnningHours'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
  final String uuid;
  final String statusUuid;
  final String modelname;
  final MachineType machineType; //機械の種類
  final int runnningHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  ///この機会がどのレベルのメンテナンス管理が必要か
  MaintenanceLevel get maintenanceLebel => machineType.maintenanceLevel;

  ///詳細なメンテナンス管理が必要か（トラクター、管理機など）
  bool get needsDetailedMaintenance =>
      maintenanceLebel == MaintenanceLevel.simple;

  ///簡易的なメンテナンス管理が必要か（コンバイン、田植え機など）
  bool get isSimpleMaintenance => maintenanceLebel == MaintenanceLevel.simple;

  Machine copyWith({
    String? statusUuid,
    String? modelname,
    int? runnningHours,
    DateTime? updatedAt,
  }) {
    return Machine(
      uuid: uuid,
      statusUuid: statusUuid ?? this.statusUuid,
      modelname: modelname ?? this.modelname,
      machineType: this.machineType,
      runnningHours: runnningHours ?? this.runnningHours,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'statusUuid': statusUuid,
      'modelname': modelname,
      'machineTyep': machineType.name,
      'runnningHours': runnningHours,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
