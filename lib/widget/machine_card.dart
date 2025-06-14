import 'package:flutter/material.dart';

class MachineCard extends StatelessWidget {
  final String machineNo; //機械ナンバー
  final String modelName; //機械モデル名
  final int runningHours; // 稼働時間
  final String status; // 機械の状態
  final Color statusColor; // 機械の状態に対応する色
  final VoidCallback? onTap; // タップ時のコールバック

  const MachineCard({
    super.key,
    required this.machineNo,
    required this.modelName,
    required this.runningHours,
    required this.status,
    required this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // カードに影を付ける
      elevation: 2,

      // 角丸にする
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      // 背景色を白に設定
      color: Colors.white,

      child: InkWell(
        // タップイベント
        onTap: onTap,
        // リップルとカードの角丸を揃える
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          // 内側余白
          padding: const EdgeInsets.all(16),
          child: Column(
            // 左寄せ
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // 機械番号とステータスを左右配置
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        machineNo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        modelName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // バッジ内余白
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    // ステータスバッジ
                    decoration: BoxDecoration(
                      color: statusColor, // ステータスに応じた色
                      borderRadius: BorderRadius.circular(12), // 角丸
                    ),

                    // ステータス表示
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // 上下間隔
              const SizedBox(height: 16),
              // 稼働時間表示ボックス
              Container(
                // 横幅最大
                width: double.infinity,
                // 内側余白
                padding: const EdgeInsets.all(12),
                // 背景色と角丸
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                // 縦レイアウト
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ラベル
                    const Text(
                      '走行時間',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 間隔
                    const SizedBox(height: 4),
                    // 時間表示
                    Text(
                      '${runningHours}h',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
