import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/machine.dart';
import 'package:farmflow/model/machine/machine_status.dart';
import 'package:farmflow/widget/maintenance_item_widget.dart';
import 'package:farmflow/widget/status_indicator.dart';

class MachineDetailScreen extends StatelessWidget {
  final Machine machine;

  const MachineDetailScreen({
    super.key,
    required this.machine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          '${machine.number} 詳細',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          _buildMachineInfoHeader(context),
          if (machine.overallStatus != MachineStatus.normal)
            _buildWarningSection(context),
          Expanded(
            child: _buildMaintenanceItemsList(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildInspectionButton(context),
    );
  }

  Widget _buildMachineInfoHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${machine.number} ${machine.modelName}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '稼働時間: ${machine.runningHours}h',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              StatusIndicator(status: machine.overallStatus),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoCard(
                context,
                '総メンテナンス項目',
                machine.maintenanceItems.length.toString(),
                Icons.build_circle,
                Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildInfoCard(
                context,
                '要確認項目',
                machine.warningItems.length.toString(),
                Icons.warning_amber,
                Colors.orange,
              ),
              const SizedBox(width: 12),
              _buildInfoCard(
                context,
                'メンテナンス必要',
                machine.maintenanceRequiredItems.length.toString(),
                Icons.error,
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningSection(BuildContext context) {
    final warningItems = machine.warningItems;
    final maintenanceItems = machine.maintenanceRequiredItems;

    if (warningItems.isEmpty && maintenanceItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: machine.overallStatus == MachineStatus.maintenance
            ? Colors.red.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: machine.overallStatus == MachineStatus.maintenance
              ? Colors.red.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                machine.overallStatus == MachineStatus.maintenance
                    ? Icons.error
                    : Icons.warning,
                color: machine.overallStatus == MachineStatus.maintenance
                    ? Colors.red[700]
                    : Colors.orange[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '注意が必要な項目があります',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: machine.overallStatus == MachineStatus.maintenance
                      ? Colors.red[700]
                      : Colors.orange[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (maintenanceItems.isNotEmpty) ...[
            Text(
              'メンテナンス必要項目: ${maintenanceItems.map((item) => item.name).join('、')}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
          ],
          if (warningItems.isNotEmpty) ...[
            Text(
              '要確認項目: ${warningItems.map((item) => item.name).join('、')}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.orange[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMaintenanceItemsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'メンテナンス状況一覧',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4CAF50),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: machine.maintenanceItems.length,
              itemBuilder: (context, index) {
                final entry = machine.maintenanceItems.entries.elementAt(index);
                final item = entry.value;
                
                return MaintenanceItemWidget(
                  item: item,
                  currentHours: machine.runningHours,
                  onTap: () {
                    _showMaintenanceDetail(context, item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            _startDailyInspection(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.checklist,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '始業前点検開始',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaintenanceDetail(BuildContext context, item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('前回交換: ${item.lastChangedHours}h'),
              Text('警告時期: ${item.warningHours}h'),
              Text('交換時期: ${item.maintenanceHours}h'),
              const SizedBox(height: 8),
              Text(
                'このメンテナンス項目の詳細情報や記録入力は将来の機能として実装予定です。',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  void _startDailyInspection(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${machine.number}の始業前点検画面に遷移'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }
}