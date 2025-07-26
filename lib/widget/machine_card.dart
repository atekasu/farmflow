/**
 * MachineCard - 機械情報表示カードウィジェット
 * 
 * 【目的】
 * 機械リスト画面で各トラクターの基本情報を一覧表示するためのカードUI
 * タップ操作により詳細画面への遷移を可能にする
 * 
 * 【責任範囲】
 * - 機械番号、型式、稼働時間の表示
 * - 全体ステータスの視覚的表現（色とアイコン）
 * - カードレイアウトとタップ処理
 * 
 * 【デザイン方針】
 * - 農業現場での視認性を重視（大きなテキスト、明確な色分け）
 * - Material Design 3に準拠したカードスタイル
 * - ステータスは左上に配置し、一目で状態が分かるUI
 */

import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/machine_status.dart';
import 'package:farmflow/model/machine/machine.dart';
import 'package:farmflow/widget/status_indicator.dart';

class MachineCard extends StatelessWidget {
  /// 表示する機械データ
  final Machine machine;
  
  /// カードタップ時のコールバック関数
  /// 詳細画面への遷移など、親ウィジェットで処理を定義
  final VoidCallback? onTap;

  const MachineCard({
    super.key,
    required this.machine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // マテリアルデザイン3の標準的な立体感を表現
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        // タップ時のリップル効果を適用
        // 農業機械管理では直感的な操作性が重要
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー部分：ステータスと機械番号を横並び表示
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 機械番号は最も重要な識別情報のため大きく表示
                  Text(
                    machine.number,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ステータスは右上に配置し、色とアイコンで直感的に表現
                  StatusIndicator(status: machine.overallStatus),
                ],
              ),
              const SizedBox(height: 8),
              
              // 機械詳細情報：型式と稼働時間
              _buildInfoRow(
                context,
                '型式',
                machine.modelName,
                Icons.agriculture,
              ),
              const SizedBox(height: 4),
              _buildInfoRow(
                context,
                '稼働時間',
                '${machine.runningHours}h',
                Icons.schedule,
              ),
              
              // 警告やメンテナンス必要項目がある場合の追加情報表示
              if (machine.overallStatus != MachineStatus.normal)
                _buildStatusDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 情報行を構築するヘルパーメソッド
  /// 
  /// ラベル、値、アイコンを統一されたレイアウトで表示
  /// DRY原則に従い、重複コードを避ける
  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// ステータス詳細情報の表示
  /// 
  /// 警告やメンテナンス必要時に、具体的な項目数を表示
  /// ユーザーが詳細画面を確認する必要性を明確に伝える
  Widget _buildStatusDetails(BuildContext context) {
    final warningCount = machine.warningItems.length;
    final maintenanceCount = machine.maintenanceRequiredItems.length;
    
    // メンテナンス必要項目を優先表示（安全性重視）
    if (maintenanceCount > 0) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'メンテナンス必要: ${maintenanceCount}項目',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.red[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    // 警告項目の表示
    if (warningCount > 0) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '要確認: ${warningCount}項目',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.orange[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}