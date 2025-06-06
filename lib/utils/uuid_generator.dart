import 'package:uuid/uuid.dart';

///アプリ全体用のuuid生成機
const _uuid = Uuid();

///uuid v4を生成する共通関数
String generateUuid() {
  return _uuid.v4();
}
///Uuid 生成機の直接アクセス（上級者用・テスト用）
Uuid get uuidGenerator => _uuid;