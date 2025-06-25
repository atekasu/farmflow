import 'package:flutter/material.dart';

class AttentionItem {
  final String title; //注意事項のタイト
  final String description; //注事項の説明
  final IconData icon; //アイコン
  final String priority; //優先度(例：'warning','info','error')

  const AttentionItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.priority,
  });
  //JSON変換用（将来の拡張性）
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'priority': priority};
  }
}
