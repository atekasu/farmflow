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

class _MachineListScreenState extends State<MachineListScreen> {}
