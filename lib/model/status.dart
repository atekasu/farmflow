import 'package:farmflow/utils/uuid_generator.dart';


class Status {
  Status({
    required this.uuid,
    required this.name,
    required this.no,
    required this.entityType,
    required this.createdAt,
    required this.updatedAt,
  });

  //ファクトリーコンストラクタ(新規作成)
  factory Status.create({
    required String name,
    required String no,
    required String entityType,
  }) {
    final now = DateTime.now();

    return Status(
      uuid: generateUuid(),
      // uuid: _uuid.v4(), // 直接UUIDを生成する場合はこちらを使用
      name: name,
      no: no,
      entityType: entityType,
      createdAt: now,
      updatedAt: now,
    );
  }
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
  final String uuid;
  final String name;
  final String no;
  final String entityType;
  final DateTime createdAt;
  final DateTime updatedAt;

  //コピーコンストラクタ
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
      createdAt: createdAt ,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
