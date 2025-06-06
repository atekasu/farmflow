import 'package:farmflow/utils/uuid_generator.dart';

/// 肥料詳細情報クラス
class Fertilizer {
  const Fertilizer({
    required this.uuid,
    required this.statusUuid,
    required this.quantity,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  //新規肥料作成用ファクトリーコンストラクタ
  factory Fertilizer.create({
    required String statusUuid,
    required double quantity,
    required String unit,
  }) {
    final now = DateTime.now();
    return Fertilizer(
      uuid: generateUuid(),
      statusUuid: statusUuid,
      quantity: quantity,
      unit: unit,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// JSON読み込み用ファクトリーコンストラクタ
  factory Fertilizer.fromJson(Map<String, dynamic> json) {
    return Fertilizer(
      uuid: json['uuid'],
      statusUuid: json['statusUuid'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  final String uuid; // UUID
  final String statusUuid; // 関連するステータスのUUID
  final double quantity; // 数量
  final String unit; // 単位（例: kg, L）
  final DateTime createdAt; // 作成日時
  final DateTime updatedAt; // 更新日時

  /// 部分変更用copyWithメソッド
  Fertilizer copyWith({String? statusUuid, double? quantity, String? unit}) {
    return Fertilizer(
      uuid: uuid,
      statusUuid: statusUuid ?? this.statusUuid,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'statusUuid': statusUuid,
      'quantity': quantity,
      'unit': unit,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
