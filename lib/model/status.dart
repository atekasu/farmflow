import 'package:farmflow/utils/uuid_generator.dart';

class Status {
  final String uuid;
  final String name;
  final String no;
  final String entityType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Status({
    required this.uuid,
    required this.name,
    required this.no,
    required this.entityType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Status.create({
    required String name,
    required String no,
    required String entityType,
  }) {
    final now = DateTime.now();
    return Status(
      uuid: generateUuid(),
      name: name,
      no: no,
      entityType: entityType,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// JSON読み込み用ファクトリーコンストラクタ
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      uuid: json['uuid'],
      name: json['name'],
      no: json['no'],
      entityType: json['entityType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  ///番号と名前を組み合わせた表示名を取得
  String get displayName => '$no: $name';

  /// エンティティタイプが機械かどうかを判定
  bool get isMachine => entityType == 'machine';

  ///エンティティタイプが肥料かどうかを判定
  bool get isFertilizer => entityType == 'fertilizer';

  ///更新された新しいインスタンス
  Status copyWith({
    String? name,
    String? no,
    String? entityType,
    DateTime? updatedAt,
  }) {
    return Status(
      uuid: uuid,
      name: name ?? this.name,
      no: no ?? this.no,
      entityType: entityType ?? this.entityType,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// JSON保存用メソッド
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'no': no,
      'entityType': entityType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
