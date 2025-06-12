import 'package:farmflow/utils/uuid_generator.dart';

/// 肥料詳細情報クラス
class Fertilizer {
  final String uuid; // UUID
  final String statusUuid; // 関連するステータスのUUID
  final double quantity; // 数量
  final String unit; // 単位（例: kg, L）
  final DateTime createdAt; // 作成日時
  final DateTime updatedAt; // 更新日時

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
      uuid: json['uuid'] as String,
      statusUuid: json['statusUuid'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  String get displayQuantity => '$quantity';

  bool get isLowStock => quantity < 10;

  String get stockStatus {
    if (quantity < 0) {
      return '在庫なし';
    } else if (quantity < 10) {
      return '在庫少なめ';
    } else {
      return '在庫十分';
    }
  }

  /// 部分変更用copyWithメソッド
  Fertilizer copyWith({
    String? statusUuid,
    double? quantity,
    String? unit,
    DateTime? updatedAt,
  }) {
    return Fertilizer(
      uuid: uuid,
      statusUuid: statusUuid ?? this.statusUuid,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  ///使用料を減産した新しいインスタンスを作成
  ///
  ///Retruns: 使用料を差し引いた新しいFertilizerインスタンス
  ///
  ///Throws: 使用量が現在の数量を超える場合はArgumentError
  Fertilizer use(double usedQuantity) {
    if (usedQuantity > quantity) {
      throw ArgumentError('使用量($usedQuantity)が現在の数量($displayQuantity)を超えています。');
    }
    return copyWith(quantity: quantity - usedQuantity);
  }

  ///補充料を加算した新しいインスタンスを作成
  ///
  ///[addQuantity]　補充する数量
  ///Returns: 補充後の新しいFertilizerインスタンス
  Fertilizer replenish(double addQuantity) {
    if (addQuantity <= 0) {
      throw ArgumentError('補充量は正の数でなければなりません。');
    }
    return copyWith(quantity: quantity + addQuantity);
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
