import 'package:flutter/material.dart';

/// メンテナンス状況項目クラス
class MaintenanceStatusItem {
  final String type; // メンテナンスの種類
  final IconData icon; // アイコン
  final Color iconColor; // アイコンの色
  final String subtitle; // サブタイトル
  final String status; // 現在のステータス
  final Color statusColor; // ステータスの色
  final double progressValue; // 進捗値（0.0〜1.0）
  final bool showProgress; // 進捗バーを表示するかどうか

  MaintenanceStatusItem({
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.progressValue,
    required this.showProgress,
  });
}