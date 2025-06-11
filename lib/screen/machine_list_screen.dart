import 'package:flutter/material.dart';
import 'package:farmflow/data/machine_dummy_data.dart';
import 'package:farmflow/widget/machine_card.dart';
import 'package:farmflow/widget/machine_status_filter.dart';

///機会一覧画面（トラクター管理画面）
class MachineListScreen extends StatefulWidget {
  const MachineListScreen({super.key});
  @override
  State<MachineListScreen> createState() => _MachineListScreenState();
}

class _MachineListScreenState extends State<MachineListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('機会一覧'),
      ),
      body: const Center(
        child: Text('機会一覧画面の内容をここに追加してください'),
      ),
    );
  }
}
