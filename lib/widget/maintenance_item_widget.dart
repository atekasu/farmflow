/**
 * MaintenanceItemWidget - メンテナンス項目表示ウィジェット
 * 
 * 【目的】
 * 機械詳細画面でメンテナンス項目の詳細情報を表示
 * 各項目の交換時期、残り時間、ステータスを分かりやすく提示
 * 
 * 【責任範囲】
 * - メンテナンス項目の名称、状態、進捗の表示
 * - 交換時期の視覚的表現（プログレスバー）
 * - 次回交換までの残り時間計算と表示
 * - タップ時の詳細表示や記録入力への誘導
 * 
 * 【ビジネスロジックの背景】
 * - 農業機械のメンテナンスは計画的な実施が重要
 * - 稼働時間ベースでの管理により、使用頻度に応じた適切なタイミングでメンテナンスを実施
 * - 警告時期を設けることで、部品調達や作業計画の時間的余裕を確保
 * 
 * 【使用例】
 * ```dart
 * // 基本的な使用
 * MaintenanceItemWidget(
 *   item: maintenanceItem,
 *   currentHours: machine.runningHours,
 * )
 * 
 * // タップ処理付き
 * MaintenanceItemWidget(
 *   item: maintenanceItem,
 *   currentHours: machine.runningHours,
 *   onTap: () => _showMaintenanceDetail(item),
 * )
 * ```
 */

import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/maintenance_item.dart';
import 'package:farmflow/widget/status_indicator.dart';

class MaintenanceItemWidget extends StatelessWidget {
  /// 表示するメンテナンス項目
  final MaintenanceItem item;
  
  /// 機械の現在の稼働時間
  /// 残り時間や進捗の計算に使用
  final int currentHours;
  
  /// ウィジェットタップ時のコールバック
  /// メンテナンス記録入力や詳細表示への遷移に使用
  final VoidCallback? onTap;
  
  /// コンパクト表示モード
  /// リスト表示時は簡潔に、詳細画面では詳細情報を表示
  final bool isCompact;

  const MaintenanceItemWidget({
    super.key,
    required this.item,
    required this.currentHours,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final status = item.getStatus(currentHours);
    final progress = _calculateProgress();
    final remainingHours = _calculateRemainingHours();

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー部：項目名とステータス
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  StatusIndicator.maintenance(
                    status: status,
                    showLabel: !isCompact,
                  ),
                ],
              ),
              
              if (!isCompact) ...[
                const SizedBox(height: 12),
                
                // 進捗バー：視覚的な交換時期の把握
                _buildProgressBar(context, progress, status),
                const SizedBox(height: 8),
                
                // 詳細情報：稼働時間と残り時間
                _buildDetailInfo(context, remainingHours),
              ] else ...[
                const SizedBox(height: 4),
                // コンパクトモードでは残り時間のみ表示
                Text(
                  _formatRemainingTime(remainingHours),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getRemainingTimeColor(status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 交換進捗の計算
  /// 
  /// 【計算ロジック】
  /// 前回交換からの経過時間を警告時間で割ることで、
  /// 0.0（交換直後）から1.0以上（警告時期超過）の値を算出
  /// 
  /// 【なぜこの計算方法か】
  /// - 警告時期を基準とすることで、余裕を持った管理が可能
  /// - プログレスバーの表現が直感的（100%で警告、100%超過で危険）
  double _calculateProgress() {
    final hoursSinceLastChange = currentHours - item.lastChangedHours;
    return hoursSinceLastChange / item.warningHours;
  }

  /// 次回交換までの残り時間を計算
  /// 
  /// 【ビジネスルール】
  /// - 正の値：まだ余裕がある時間
  /// - 負の値：既に交換時期を過ぎている時間
  /// 
  /// この情報により、緊急度と作業計画の優先順位を判断
  int _calculateRemainingHours() {
    final hoursSinceLastChange = currentHours - item.lastChangedHours;
    return item.maintenanceHours - hoursSinceLastChange;
  }

  /// 進捗バーの構築
  /// 
  /// 【色分けロジック】
  /// - 緑: 正常範囲（0-80%）
  /// - オレンジ: 警告範囲（80-100%）
  /// - 赤: 危険範囲（100%超）
  /// 
  /// 視認性を高めるため、背景色とプログレス色の両方で状態を表現
  Widget _buildProgressBar(
    BuildContext context,
    double progress,
    MaintenanceItemStatus status,
  ) {
    Color progressColor;
    switch (status) {
      case MaintenanceItemStatus.normal:
        progressColor = Colors.green;
        break;
      case MaintenanceItemStatus.warning:
        progressColor = Colors.orange;
        break;
      case MaintenanceItemStatus.maintenance:
        progressColor = Colors.red;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '交換進捗',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${(progress * 100).clamp(0, 999).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: progressColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          minHeight: 6,
        ),
      ],
    );
  }

  /// 詳細情報の構築
  /// 
  /// 稼働時間の詳細情報を表形式で整理
  /// メンテナンス計画立案に必要な具体的数値を提供
  Widget _buildDetailInfo(BuildContext context, int remainingHours) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            '前回交換',
            '${item.lastChangedHours}h',
          ),
          const SizedBox(height: 4),
          _buildInfoRow(
            context,
            '現在稼働',
            '${currentHours}h',
          ),
          const SizedBox(height: 4),
          _buildInfoRow(
            context,
            '次回交換',
            _formatRemainingTime(remainingHours),
            isHighlight: remainingHours <= 0,
          ),
        ],
      ),
    );
  }

  /// 情報行の構築ヘルパー
  /// 
  /// ラベルと値を整列させ、読みやすい表形式を実現
  /// 重要な情報（超過時）は強調表示
  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isHighlight ? Colors.red : null,
          ),
        ),
      ],
    );
  }

  /// 残り時間の表示形式整形
  /// 
  /// 【表示ルール】
  /// - 正の値: "あと○○h"（余裕がある表現）
  /// - 負の値: "○○h超過"（緊急性を強調する表現）
  /// 
  /// 日本語表現により、現場作業者にとって理解しやすい情報提供
  String _formatRemainingTime(int remainingHours) {
    if (remainingHours > 0) {
      return 'あと${remainingHours}h';
    } else {
      return '${remainingHours.abs()}h超過';
    }
  }

  /// 残り時間表示色の取得
  /// 
  /// ステータスに応じた色分けにより、緊急度を視覚的に表現
  /// 特に超過時は赤色で注意を喚起
  Color _getRemainingTimeColor(MaintenanceItemStatus status) {
    switch (status) {
      case MaintenanceItemStatus.normal:
        return Colors.green;
      case MaintenanceItemStatus.warning:
        return Colors.orange[700]!;
      case MaintenanceItemStatus.maintenance:
        return Colors.red[700]!;
    }
  }
}