import 'package:flutter/material.dart';
import 'package:farmflow/model/machine/machine.dart';

enum InspectionStatus {
  notChecked,
  good,
  warning,
  bad,
}

class InspectionItem {
  final String name;
  final String description;
  final IconData icon;
  InspectionStatus status;

  InspectionItem({
    required this.name,
    required this.description,
    required this.icon,
    this.status = InspectionStatus.notChecked,
  });
}

class MaintenanceCheckScreen extends StatefulWidget {
  final Machine machine;

  const MaintenanceCheckScreen({
    super.key,
    required this.machine,
  });

  @override
  State<MaintenanceCheckScreen> createState() => _MaintenanceCheckScreenState();
}

class _MaintenanceCheckScreenState extends State<MaintenanceCheckScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<InspectionItem> _inspectionItems;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _inspectionItems = _getInspectionItems();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<InspectionItem> _getInspectionItems() {
    return [
      InspectionItem(
        name: 'エンジンオイル',
        description: 'オイル量とオイルの汚れ具合を確認してください',
        icon: Icons.oil_barrel,
      ),
      InspectionItem(
        name: 'ミッションオイル',
        description: 'トランスミッションオイル量を確認してください',
        icon: Icons.settings,
      ),
      InspectionItem(
        name: '冷却水',
        description: 'クーラント量とラジエーター周りを確認してください',
        icon: Icons.water_drop,
      ),
      InspectionItem(
        name: 'グリース',
        description: 'グリースニップルの状態を確認してください',
        icon: Icons.agriculture,
      ),
      InspectionItem(
        name: 'エアフィルター',
        description: 'フィルターの汚れや破損がないか確認してください',
        icon: Icons.air,
      ),
      InspectionItem(
        name: 'ファンベルト',
        description: 'ベルトの張り具合とひび割れを確認してください',
        icon: Icons.linear_scale,
      ),
      InspectionItem(
        name: 'タイヤ',
        description: 'タイヤの摩耗とタイヤ圧を確認してください',
        icon: Icons.circle,
      ),
      InspectionItem(
        name: '燃料フィルター',
        description: 'フィルターの詰まりがないか確認してください',
        icon: Icons.filter_alt,
      ),
      InspectionItem(
        name: 'ブレーキワイヤー',
        description: 'ワイヤーの張り具合と損傷を確認してください',
        icon: Icons.cable,
      ),
      InspectionItem(
        name: 'ラジエーターホース',
        description: 'ホースの亀裂や漏れがないか確認してください',
        icon: Icons.plumbing,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          '${widget.machine.number} 始業前点検',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _inspectionItems.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildInspectionCard(_inspectionItems[index]);
              },
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
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
        children: [
          Text(
            '${_currentIndex + 1} / ${_inspectionItems.length}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _inspectionItems.asMap().entries.map((entry) {
              int index = entry.key;
              InspectionItem item = entry.value;
              
              Color dotColor;
              if (item.status == InspectionStatus.good) {
                dotColor = Colors.green;
              } else if (item.status == InspectionStatus.warning) {
                dotColor = Colors.orange;
              } else if (item.status == InspectionStatus.bad) {
                dotColor = Colors.red;
              } else if (index == _currentIndex) {
                dotColor = const Color(0xFF4CAF50);
              } else {
                dotColor = Colors.grey[300]!;
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(
                  '●',
                  style: TextStyle(
                    color: dotColor,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionCard(InspectionItem item) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 48,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                item.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4CAF50),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildStatusButtons(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButtons(InspectionItem item) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => _setStatus(item, InspectionStatus.good),
            style: ElevatedButton.styleFrom(
              backgroundColor: item.status == InspectionStatus.good
                  ? Colors.green
                  : Colors.green.withOpacity(0.1),
              foregroundColor: item.status == InspectionStatus.good
                  ? Colors.white
                  : Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.green,
                  width: item.status == InspectionStatus.good ? 0 : 2,
                ),
              ),
              elevation: item.status == InspectionStatus.good ? 4 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 24),
                const SizedBox(width: 8),
                Text(
                  '良好',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => _setStatus(item, InspectionStatus.warning),
            style: ElevatedButton.styleFrom(
              backgroundColor: item.status == InspectionStatus.warning
                  ? Colors.orange
                  : Colors.orange.withOpacity(0.1),
              foregroundColor: item.status == InspectionStatus.warning
                  ? Colors.white
                  : Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.orange,
                  width: item.status == InspectionStatus.warning ? 0 : 2,
                ),
              ),
              elevation: item.status == InspectionStatus.warning ? 4 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, size: 24),
                const SizedBox(width: 8),
                Text(
                  '要確認',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => _setStatus(item, InspectionStatus.bad),
            style: ElevatedButton.styleFrom(
              backgroundColor: item.status == InspectionStatus.bad
                  ? Colors.red
                  : Colors.red.withOpacity(0.1),
              foregroundColor: item.status == InspectionStatus.bad
                  ? Colors.white
                  : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.red,
                  width: item.status == InspectionStatus.bad ? 0 : 2,
                ),
              ),
              elevation: item.status == InspectionStatus.bad ? 4 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 24),
                const SizedBox(width: 8),
                Text(
                  '不良',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
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
      child: Row(
        children: [
          if (_currentIndex > 0)
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4CAF50)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '前へ',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (_currentIndex > 0 && _currentIndex < _inspectionItems.length - 1)
            const SizedBox(width: 16),
          if (_currentIndex < _inspectionItems.length - 1)
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '次へ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          if (_currentIndex == _inspectionItems.length - 1)
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _completeInspection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '点検完了',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _setStatus(InspectionItem item, InspectionStatus status) {
    setState(() {
      item.status = status;
    });
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentIndex < _inspectionItems.length - 1) {
        _nextPage();
      }
    });
  }

  void _nextPage() {
    if (_currentIndex < _inspectionItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeInspection() {
    final incompleteItems = _inspectionItems
        .where((item) => item.status == InspectionStatus.notChecked)
        .toList();

    if (incompleteItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('未点検項目があります'),
            content: Text(
              '以下の項目がまだ点検されていません：\n${incompleteItems.map((item) => item.name).join('、')}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('戻る'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _finishInspection();
                },
                child: const Text('このまま完了'),
              ),
            ],
          );
        },
      );
    } else {
      _finishInspection();
    }
  }

  void _finishInspection() {
    final goodCount = _inspectionItems.where((item) => item.status == InspectionStatus.good).length;
    final warningCount = _inspectionItems.where((item) => item.status == InspectionStatus.warning).length;
    final badCount = _inspectionItems.where((item) => item.status == InspectionStatus.bad).length;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('点検完了'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.machine.number}の始業前点検が完了しました。'),
              const SizedBox(height: 16),
              Text('結果:'),
              Text('良好: ${goodCount}項目', style: const TextStyle(color: Colors.green)),
              Text('要確認: ${warningCount}項目', style: const TextStyle(color: Colors.orange)),
              Text('不良: ${badCount}項目', style: const TextStyle(color: Colors.red)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('完了'),
            ),
          ],
        );
      },
    );
  }
}