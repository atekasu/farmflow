import 'dart:ffi';

import 'package:flutter/material.dart';

class MachineCard {
  final String machineNo; //機械ナンバー
  final String modelName; //機械モデル名
  final int runningHours; // 稼働時間
  final String status; // 機械の状態
  final Color statusColor; // 機械の状態に対応する色
  final VoidCallback? onTap; // タップ時のコールバック

  const MachineCard({
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
      // カードの立体感（影の深さ）を設定
      elevation: 2,

      //カードの角を丸くする
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      //カードの背景色を白に設定
      color: Colors.white,

      child: InkWell(
        // タップされた時の処理を設定
        onTap: onTap,
        //リップルエフェクトの革マルをカードと合わせる
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16), //カードの内側の余白を設定
          child: Column(
            //左寄せに設定（デフォルトは中央よせ）
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //左右に要素を配置（左：機械番号、右：ステータス）
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

                      // 機械モデル名を表示
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
                    //内側の余白設定
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    //ステータスバッジのデザイン
                    decoration: BoxDecoration(
                      color: statusColor, // ステータスに応じた色
                      borderRadius: BorderRadius.circular(12), // 角を丸くする
                    ),

                    //ステータスのテキスト
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
              //=====中間：上部と下部の間に16pxの余白
              const SizedBox(height: 16),
              //=====下部：走行時間を表示する青いボックス
              Container(
                //横幅を親要素いっぱいにする
                width: double.infinity,
                //内側の余白を設定
                padding: const EdgeInsets.all(12),
                //ボックスデザイン
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                //ボックス内の内容を縦に配置
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ラベル「走行時間」
                    const Text(
                      '走行時間',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //ラベルと数字の間に4pxの余白
                    const SizedBox(height: 4),
                    //実際の走行時間
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
