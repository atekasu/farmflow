import 'package:flutter/material.dart';
import 'package:farmflow/model/entities/machine.dart';
import 'package:farmflow/data/models/attention_item.dart';

/// 注意事項アイテム生成サービス
class AttentionItemsGenerator {
  /// 注意事項アイテムを生成（稼働時間に基づく）
  static List<AttentionItem> generateAttentionItems(Machine machine) {
    List<AttentionItem> items = [];

    // 稼働時間に基づく注意事項を追加
    if (machine.runningHours >= 2000) {
      items.add(AttentionItem(
        title: 'メンテナンス時期',
        description: '稼働時間が${machine.runningHours}時間を超えています。定期メンテナンスを実施してください。',
        icon: Icons.warning,
        priority: 'high',
      ));
    } else if (machine.runningHours >= 1900) {
      items.add(AttentionItem(
        title: '点検推奨',
        description: '稼働時間が${machine.runningHours}時間に達しました。点検をお勧めします。',
        icon: Icons.info,
        priority: 'medium',
      ));
    }

    // 機械タイプ別の注意事項
    switch (machine.machineType.name) {
      case 'tractor':
        items.add(AttentionItem(
          title: 'トラクター専用点検',
          description: '油圧系統とタイヤの空気圧を定期的に確認してください。',
          icon: Icons.build,
          priority: 'low',
        ));
        break;
      case 'combine':
        items.add(AttentionItem(
          title: 'コンバイン専用点検',
          description: '刈り取り部の刃の状態を確認してください。',
          icon: Icons.agriculture,
          priority: 'low',
        ));
        break;
    }

    return items;
  }
}