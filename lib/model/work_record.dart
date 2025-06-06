import 'package:farmflow/utils/uuid_generator.dart';

///簡易記録のクラス（簡易管理用機会）
class WorkRecord {
  const WorkRecord({
    required this.uuid,
    required this.machineUuid,
    required this.workDate,
    required this.workHours,
    required this.workType,
    this.fieldName,
    this.workArea,
    this.notes,
    required this.createdAt,
  });
  //ファクトリーコンストラクタ(新規作成)
  factory WorkRecord.create({
    required String machineUuid,
    required DateTime workDate,
    required double workHours,
    required String workType,
    String? fieldName,
    double? workArea,
    String? notes,
  }) {
    return WorkRecord(
      uuid: generateUuid(),
      machineUuid: machineUuid,
      workDate: workDate,
      workHours: workHours,
      workType: workType,
      fieldName: fieldName,
      workArea: workArea,
      notes: notes,
      createdAt: DateTime.now(),
    );
  }

  /// JSON読込用ファクトリーコンストラクタ
  factory WorkRecord.fromJson(Map<String, dynamic> json) {
    return WorkRecord(
      uuid: json['uuid'],
      machineUuid: json['machineUuid'],
      workDate: DateTime.parse(json['workDate']),
      workHours: json['workHours'].toDouble(),
      workType: json['workType'],
      fieldName: json['fieldName'],
      workArea: json['workArea']?.toDouble(),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  final String uuid; // UUID
  final String machineUuid; // 関連する機械のUUID
  final DateTime workDate; // 作業日
  final double workHours; // 作業時間
  final String workType; // 作業の種類
  final String? fieldName; // 作業したフィールド名
  final double? workArea; // 作業面積（ヘクタール）
  final String? notes; // 作業に関するメモ
  final DateTime createdAt; // 作成日時
  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'machineUuid': machineUuid,
      'workDate': workDate.toIso8601String(),
      'workHours': workHours,
      'workType': workType,
      'fieldName': fieldName,
      'workArea': workArea,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
