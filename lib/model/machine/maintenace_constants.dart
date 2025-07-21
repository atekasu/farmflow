import 'package:farmflow/model/machine/maintenace_item.dart';

///メンテナンス間隔の定数
class MaintenanceConstants {
  const MaintenanceConstants._(); //インスタンスかを防ぐ
  //エンジンオイル
  static const int enginOilWarningHours = 150;
  static const int enginOilMaintenaceHours = 200;

  //オイルフィルター
  static const int oilFilterWarningHours = 180;
  static const int oilFilterMaintenanceHours = 200;

  // ミッションオイル
  static const int missionOilWarningHours = 350;
  static const int missionOilMaintenanceHours = 400;

  // エアフィルター
  static const int airFilterWarningHours = 180;
  static const int airFilterMaintenanceHours = 200;

  // グリース給脂
  static const int greaseWarningHours = 45;
  static const int greaseMaintenanceHours = 50;
}

///メンテナンス項目の定義
class MaintenaceConfig {
  const MaintenaceConfig({
    required this.name,
    required this.warningHours,
    required this.maintenanceHours,
  });
  final String name; //メンテナンス項目名
  final int warningHours; //警告を出す稼働時間
  final int maintenanceHours; //交換までの時間
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastChangedHours': 0, // 初期値は0
      'warningHours': warningHours,
      'maintenanceHours': maintenanceHours,
    };
  }

  //標準的なメンテナンス項目の設定
  static const Map<String, MaintenaceConfig> standardItems = {
    'engineOil': MaintenaceConfig(
      name: 'エンジンオイル',
      warningHours: MaintenanceConstants.enginOilWarningHours,
      maintenanceHours: MaintenanceConstants.enginOilMaintenaceHours,
    ),
    'oilFilter': MaintenaceConfig(
      name: 'オイルフィルター',
      warningHours: MaintenanceConstants.oilFilterWarningHours,
      maintenanceHours: MaintenanceConstants.oilFilterMaintenanceHours,
    ),
    'missionOil': MaintenaceConfig(
      name: 'ミッションオイル',
      warningHours: MaintenanceConstants.missionOilWarningHours,
      maintenanceHours: MaintenanceConstants.missionOilMaintenanceHours,
    ),
    'airFilter': MaintenaceConfig(
      name: 'エアフィルター',
      warningHours: MaintenanceConstants.airFilterWarningHours,
      maintenanceHours: MaintenanceConstants.airFilterMaintenanceHours,
    ),
    'grease': MaintenaceConfig(
      name: 'グリース給脂',
      warningHours: MaintenanceConstants.greaseWarningHours,
      maintenanceHours: MaintenanceConstants.greaseMaintenanceHours,
    ),
  };
}
