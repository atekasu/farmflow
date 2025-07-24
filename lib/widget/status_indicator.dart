/**
 * StatusIndicator - 機械・メンテナンス項目のステータス表示ウィジェット
 * 
 * 【目的】
 * 機械の状態やメンテナンス項目の状態を色とアイコンで視覚的に表現
 * 農業現場での迅速な状況判断をサポートする
 * 
 * 【責任範囲】
 * - MachineStatusの視覚的表現（色・アイコン・ラベル）
 * - MaintenanceItemStatusの視覚的表現
 * - 一貫性のあるデザインシステムの提供
 * 
 * 【デザイン方針】
 * - 国際的な色彩心理学に基づく色使い（緑=安全、オレンジ=注意、赤=危険）
 * - アイコンとテキストの組み合わせでアクセシビリティを向上
 * - 屋外作業での視認性を考慮した十分なコントラスト
 * 
 * 【使用例】
 * ```dart
 * // 機械の全体ステータス表示
 * StatusIndicator(status: machine.overallStatus)
 * 
 * // メンテナンス項目の個別ステータス表示
 * StatusIndicator.maintenance(
 *   status: MaintenanceItemStatus.warning,
 *   showLabel: true,
 * )
 * ```
 */

import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/machine_status.dart';
import 'package:farmflow/model/machine/maintenance_item.dart';

class StatusIndicator extends StatelessWidget {
  /// 表示する機械ステータス
  final MachineStatus? machineStatus;
  
  /// 表示するメンテナンス項目ステータス
  final MaintenanceItemStatus? maintenanceStatus;
  
  /// ラベルテキストの表示有無
  /// 小さなスペースではアイコンのみ、詳細表示ではテキスト付きで使い分け
  final bool showLabel;
  
  /// インジケーターのサイズ
  /// コンテキストに応じて適切なサイズで表示するため
  final double size;

  /// 機械ステータス用コンストラクタ
  const StatusIndicator({
    super.key,
    required MachineStatus status,
    this.showLabel = false,
    this.size = 24.0,
  }) : machineStatus = status,
       maintenanceStatus = null;

  /// メンテナンス項目ステータス用コンストラクタ
  /// 
  /// 機械全体ステータスとは異なる表現が必要な場合に使用
  /// より詳細な状態管理が可能
  const StatusIndicator.maintenance({
    super.key,
    required MaintenanceItemStatus status,
    this.showLabel = false,
    this.size = 24.0,
  }) : maintenanceStatus = status,
       machineStatus = null;

  @override
  Widget build(BuildContext context) {
    // どちらのステータスタイプも指定されていない場合のエラーハンドリング
    if (machineStatus == null && maintenanceStatus == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: showLabel 
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
        : const EdgeInsets.all(4),
      decoration: showLabel
        ? BoxDecoration(
            color: _getStatusColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _getStatusColor().withOpacity(0.3),
              width: 1,
            ),
          )
        : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(),
            color: _getStatusColor(),
            size: size,
          ),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              _getStatusLabel(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getStatusColor(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// ステータスに対応する色を取得
  /// 
  /// 【色の選択理由】
  /// - 緑: 正常状態、安心感を与える色
  /// - オレンジ: 注意喚起、早めの対応を促す色
  /// - 赤: 緊急性、即座の対応が必要な色
  /// 
  /// 農業現場では屋外での視認性が重要なため、
  /// 十分なコントラストを持つ色を選択
  Color _getStatusColor() {
    if (machineStatus != null) {
      return machineStatus!.color;
    }
    
    // メンテナンス項目ステータスの色マッピング
    switch (maintenanceStatus!) {
      case MaintenanceItemStatus.normal:
        return Colors.green;
      case MaintenanceItemStatus.warning:
        return Colors.orange;
      case MaintenanceItemStatus.maintenance:
        return Colors.red;
    }
  }

  /// ステータスに対応するアイコンを取得
  /// 
  /// 【アイコンの選択理由】
  /// - check_circle: 完了・正常を表す普遍的なアイコン
  /// - warning: 注意・警告を表す国際的に認知されたアイコン
  /// - build: メンテナンス・修理を表す直感的なアイコン
  /// 
  /// 色覚異常者にも配慮し、形状でも区別可能
  IconData _getStatusIcon() {
    if (machineStatus != null) {
      return machineStatus!.icon;
    }
    
    // メンテナンス項目ステータスのアイコンマッピング
    switch (maintenanceStatus!) {
      case MaintenanceItemStatus.normal:
        return Icons.check_circle;
      case MaintenanceItemStatus.warning:
        return Icons.warning;
      case MaintenanceItemStatus.maintenance:
        return Icons.build;
    }
  }

  /// ステータスに対応するラベルテキストを取得
  /// 
  /// 日本語ラベルにより、現場作業者にとって理解しやすい表現を提供
  /// 略語や専門用語を避け、直感的な表現を心がける
  String _getStatusLabel() {
    if (machineStatus != null) {
      return machineStatus!.label;
    }
    
    // メンテナンス項目ステータスのラベルマッピング
    switch (maintenanceStatus!) {
      case MaintenanceItemStatus.normal:
        return '正常';
      case MaintenanceItemStatus.warning:
        return '要確認';
      case MaintenanceItemStatus.maintenance:
        return '要交換';
    }
  }
}