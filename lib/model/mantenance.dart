import 'package:uuid/uuid.dart';

enum MaintenanceType {
  engineOil,
  oilFilter,
  missionOil,
  airFilter,
  grease,
  general;

  String get label {
    switch (this) {
      case MaintenanceType.engineOil:
        return 'エンジンオイル交換';
      case MaintenanceType.oilFilter:
        return 'オイルフィルター交換';
      case MaintenanceType.missionOil:
        return 'ミッションオイル交換';
      case MaintenanceType.airFilter:
        return 'エアフィルター交換';
      case MaintenanceType.grease:
        return 'グリース給脂';
      case MaintenanceType.general:
        return '一般整備';
    }
  }
}

class MaintenanceRecord {
  const MaintenanceRecord({
    required this.id,
    required this.machineId,
    required this.type,
    required this.date,
    required this.runningHours,
    this.notes = '',
    this.nextDueHours,
  });

  final String id;
  final String machineId;
  final MaintenanceType type;
  final DateTime date;
  final int runningHours; // 実施時の稼働時間
  final String notes; // メモ
  final int? nextDueHours; // 次回実施予定時間

  // 新規メンテナンス記録作成用（ID自動生成）
  factory MaintenanceRecord.create({
    required String machineId,
    required MaintenanceType type,
    required int runningHours,
    DateTime? date,
    String notes = '',
    int? nextDueHours,
  }) {
    return MaintenanceRecord(
      id: const Uuid().v4(),
      machineId: machineId,
      type: type,
      date: date ?? DateTime.now(),
      runningHours: runningHours,
      notes: notes,
      nextDueHours: nextDueHours,
    );
  }

  // Firebase用のJSON変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'machineId': machineId,
      'type': type.name,
      'date': date.toIso8601String(),
      'runningHours': runningHours,
      'notes': notes,
      'nextDueHours': nextDueHours,
    };
  }

  // Firebaseからデータ作成用
  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
    return MaintenanceRecord(
      id: json['id'] as String,
      machineId: json['machineId'] as String,
      type: MaintenanceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MaintenanceType.general,
      ),
      date: DateTime.parse(json['date'] as String),
      runningHours: json['runningHours'] as int,
      notes: json['notes'] as String? ?? '',
      nextDueHours: json['nextDueHours'] as int?,
    );
  }

  MaintenanceRecord copyWith({
    String? id,
    String? machineId,
    MaintenanceType? type,
    DateTime? date,
    int? runningHours,
    String? notes,
    int? nextDueHours,
  }) {
    return MaintenanceRecord(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      type: type ?? this.type,
      date: date ?? this.date,
      runningHours: runningHours ?? this.runningHours,
      notes: notes ?? this.notes,
      nextDueHours: nextDueHours ?? this.nextDueHours,
    );
  }
}
