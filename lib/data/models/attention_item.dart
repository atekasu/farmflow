import 'package:flutter/material.dart';

/// 注意事項項目クラス
class AttentionItem {
  final String title; // 注意事項のタイトル
  final String description; // 注意事項の説明
  final IconData icon; // アイコン
  final String priority; // 優先度（例: 'high', 'medium', 'low'）

  AttentionItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.priority,
  });
}