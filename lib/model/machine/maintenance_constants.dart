import 'package:farmflow/model/machine/maintenance_item.dart';

///メンテナンス間隔の定数
class MaintenanceConstants {
  const MaintenanceConstants._(); //インスタンス化を防ぐ
  //エンジンオイル
  static const int engineOilWarningHours = 150; //エンジンオイルの警告時間
  static const int engineOilMaintenanceHours = 200; //エンジンオイルの交換時間

  //オイルフィルター
  static const int oilFilterWarningHours = 180; //オイルフィルター警告時間
  static const int oilFilterMaintenanceHours = 200; //オイルフィルターの交換時間

  // ミッションオイル
  static const int transmissionOilWarningHours = 350; //ミッションオイルの警告閾値
  static const int transmissionOilMaintenanceHours = 400; //ミッションオイルの交換時間

  // エアフィルター
  static const int airFilterWarningHours = 180; //エアフィルターの警告時間
  static const int airFilterMaintenanceHours = 200; //エアフィルターの交換時間

  // グリース給脂
  static const int greaseWarningHours = 45; //グリース給脂の警告時間
  static const int greaseMaintenanceHours = 50; //グリース給脂の交換時間
}

///メンテナンス項目の定義
class MaintenanceConfig {
  final String name; //メンテナンス項目名
  final int warningHours; //警告を出す稼働時間
  final int maintenanceHours; //交換までの時間

  //コンスタラクタ
  const MaintenanceConfig({
    required this.name,
    required this.warningHours,
    required this.maintenanceHours,
  });

  //MaintenanceItemを作成するペルパーメソッド
  MaintenanceItem createItem({int initialHours = 0}) {
    return MaintenanceItem.fromConfig(
      name: name,
      warningHours: warningHours,
      maintenanceHours: maintenanceHours,
      initialHours: initialHours,
    );
  }

  //標準的なメンテナンス項目の設定
  static const Map<String, MaintenanceConfig> standardItems = {
    'engineOil': MaintenanceConfig(
      name: 'エンジンオイル',
      warningHours: MaintenanceConstants.engineOilWarningHours,
      maintenanceHours: MaintenanceConstants.engineOilMaintenanceHours,
    ),
    'oilFilter': MaintenanceConfig(
      name: 'オイルフィルター',
      warningHours: MaintenanceConstants.oilFilterWarningHours,
      maintenanceHours: MaintenanceConstants.oilFilterMaintenanceHours,
    ),
    'transmissionOil': MaintenanceConfig(
      name: 'ミッションオイル',
      warningHours: MaintenanceConstants.transmissionOilWarningHours,
      maintenanceHours: MaintenanceConstants.transmissionOilMaintenanceHours,
    ),
    'airFilter': MaintenanceConfig(
      name: 'エアフィルター',
      warningHours: MaintenanceConstants.airFilterWarningHours,
      maintenanceHours: MaintenanceConstants.airFilterMaintenanceHours,
    ),
    'grease': MaintenanceConfig(
      name: 'グリース給脂',
      warningHours: MaintenanceConstants.greaseWarningHours,
      maintenanceHours: MaintenanceConstants.greaseMaintenanceHours,
    ),
  };
}
