import 'package:farmflow/model/machine/maintenance_item.dart';
import 'package:flutter/material.dart';

class MaintenanceInfo {
  final String description;
  final IconData icon;

  const MaintenanceInfo({required this.description, required this.icon});
}

const Map<String, MaintenanceInfo> maintenanceInfoMap = {
  'エンジンオイル': MaintenanceInfo(
    description: 'オイル量とオイルの汚れ具合を確認してください',
    icon: Icons.oil_barrel,
  ),
  'ミッションオイル': MaintenanceInfo(
    description: 'トランスミッションオイル量を確認してください',
    icon: Icons.settings,
  ),
  '冷却水': MaintenanceInfo(
    description: 'クーラント量とラジエーター周りを確認してください',
    icon: Icons.water_drop,
  ),
  'グリース': MaintenanceInfo(
    description: 'グリースニップルの状態を確認してください',
    icon: Icons.agriculture,
  ),
  'エアフィルター': MaintenanceInfo(
    description: 'フィルターの汚れや破損がないか確認してください',
    icon: Icons.air,
  ),
  'ファンベルト': MaintenanceInfo(
    description: 'ベルトの張り具合とひび割れを確認してください',
    icon: Icons.linear_scale,
  ),
  'タイヤ': MaintenanceInfo(
    description: 'タイヤの摩耗とタイヤ圧を確認してください',
    icon: Icons.circle,
  ),
  '燃料フィルター': MaintenanceInfo(
    description: 'フィルターの詰まりがないか確認してください',
    icon: Icons.filter_alt,
  ),
  'ブレーキワイヤー': MaintenanceInfo(
    description: 'ワイヤーの張り具合と損傷を確認してください',
    icon: Icons.cable,
  ),
  'ラジエーターホース': MaintenanceInfo(
    description: 'ホースの亀裂や漏れがないか確認してください',
    icon: Icons.plumbing,
  ),
};

class MaintenanceConfig {
  final int warningHours;
  final int maintenanceHours;

  const MaintenanceConfig({
    required this.warningHours,
    required this.maintenanceHours,
  });

  MaintenanceItem createItem({required String name, int initialHours = 0}) {
    return MaintenanceItem(
      name: name,
      lastChangedHours: initialHours,
      warningHours: warningHours,
      maintenanceHours: maintenanceHours,
    );
  }

  static final Map<String, MaintenanceConfig> standardItems = {
    'エンジンオイル': const MaintenanceConfig(warningHours: 80, maintenanceHours: 100),
    'ミッションオイル':
        const MaintenanceConfig(warningHours: 250, maintenanceHours: 300),
    '冷却水': const MaintenanceConfig(warningHours: 180, maintenanceHours: 200),
    'グリース': const MaintenanceConfig(warningHours: 40, maintenanceHours: 50),
    'エアフィルター': const MaintenanceConfig(warningHours: 80, maintenanceHours: 100),
    'ファンベルト': const MaintenanceConfig(warningHours: 450, maintenanceHours: 500),
    'タイヤ': const MaintenanceConfig(warningHours: 900, maintenanceHours: 1000),
    '燃料フィルター': const MaintenanceConfig(warningHours: 350, maintenanceHours: 400),
    'ブレーキワイヤー':
        const MaintenanceConfig(warningHours: 550, maintenanceHours: 600),
    'ラジエーターホース':
        const MaintenanceConfig(warningHours: 550, maintenanceHours: 600),
  };
}
