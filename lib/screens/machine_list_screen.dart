import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/machine.dart';
import 'package:farmflow/model/machine/machine_status.dart';
import 'package:farmflow/widget/machine_card.dart';

class MachineListScreen extends StatelessWidget {
  const MachineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'トラクター管理',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
            tooltip: 'フィルター',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4CAF50).withOpacity(0.1),
                  Colors.blue.withOpacity(0.1),
                ],
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.agriculture,
                  color: Color(0xFF4CAF50),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '登録台数: ${_getDummyMachines().length}台',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _getDummyMachines().length,
              itemBuilder: (context, index) {
                final machine = _getDummyMachines()[index];
                return MachineCard(
                  machine: machine,
                  onTap: () {
                    _navigateToMachineDetail(context, machine);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddMachine(context);
        },
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Machine> _getDummyMachines() {
    return [
      Machine.create(
        number: 'No1',
        modelName: 'SL400',
        runningHours: 1880,
      ),
      Machine.create(
        number: 'No2',
        modelName: 'SL400',
        runningHours: 1850,
      ),
      Machine.create(
        number: 'No3',
        modelName: 'SL400',
        runningHours: 1850,
      ),
    ];
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('フィルター'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  MachineStatus.normal.icon,
                  color: MachineStatus.normal.color,
                ),
                title: Text(MachineStatus.normal.label),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  MachineStatus.warning.icon,
                  color: MachineStatus.warning.color,
                ),
                title: Text(MachineStatus.warning.label),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  MachineStatus.maintenance.icon,
                  color: MachineStatus.maintenance.color,
                ),
                title: Text(MachineStatus.maintenance.label),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMachineDetail(BuildContext context, Machine machine) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${machine.number}の詳細画面に遷移'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _navigateToAddMachine(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('機械追加画面に遷移'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}