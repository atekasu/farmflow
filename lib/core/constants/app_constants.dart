class MaintenaceConstants {
  static const int WARNING_THRESHOLD_PERCENT = 80; //交換推奨時間の80%で警告
  static const int ENGINE_OIL_CHANGE_INTERVAL = 150; // エンジンオイル交換間隔
  static const int MISSION_OIL_CHANGE_INTERVAL = 200; // ミッションオイル交換間隔
  static const int AIR_FILTER_CHANGE_INTERVAL = 100; // エアフィルター交換間隔
}

class MachinTypeIds {
  static const String TRACTOR = 'tractor';
  static const String COMBINE = 'combine';
  static const String PLANTING = 'planting';
  static const String ATTACHMENT = 'attachment';
}
