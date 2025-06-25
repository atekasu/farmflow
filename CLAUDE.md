# CLAUDE.md
必ず日本語で回答してください。

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🚨 必須制約（コード生成時・最優先）

### 1ファイル1機能原則（厳守）
- **1つのファイルには1つの責任のみ**
- **150行以下**を目標、200行超えたら**必ず分割提案**
- 複数の責任がある場合は、別ファイルに分割して提案してください

### AI支援時の指示テンプレート
```
「1ファイル1機能原則に従って、150行以下でコード生成してください。
複数の責任がある場合は、別ファイルに分割して提案してください。
MVPファーストでまず動くものを作ってください。」
```

### 分割例
❌ **悪い例**: `maintenance_record.dart` (240行)
- MaintenanceType enum + MaintenanceRecord class

✅ **良い例**: 分割後
- `maintenance_type.dart` (140行) - enum定義のみ
- `maintenance_record.dart` (100行) - クラス定義のみ

---

## Project Overview

FarmFlow is a Flutter application for managing agricultural machinery, tracking maintenance schedules, and monitoring equipment status. The app focuses on tractors, combines, planters, cultivators, and attachments with different levels of maintenance management.

## Development Commands

### Core Flutter Commands
```bash
# Navigate to the Flutter project directory
cd farmflow

# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run

# Build for different platforms
flutter build apk
flutter build ios
flutter build web

# Run tests
flutter test

# Analyze code for issues
flutter analyze

# Format code
dart format .
```

### Dependency Management
```bash
# Update dependencies
flutter pub upgrade

# Add new dependencies
flutter pub add <package_name>

# Remove dependencies  
flutter pub remove <package_name>
```

## Architecture Overview

### Model Layer (`lib/model/`) - 1モデル1ファイル厳守
- **Machine**: Base class for all agricultural equipment with UUID tracking, maintenance levels, and JSON serialization
- **MachineType**: Enum defining equipment types (tractor, combine, planter, cultivator, attachment) with associated maintenance levels
- **Status**: Entity status tracking with UUID and timestamps
- **Tractor**: Specialized machine model with hydraulic and tire pressure data
- **MaintenanceRecord** & **WorkRecord**: Track maintenance and operational history

### Data Management (`lib/data/`)
- **MachineDummyData**: Provides test data for development including machines, statuses, and composite data structures
- Contains helper classes like `MachineWithStatus` for UI display
- Includes health status calculation and filtering logic

### UI Layer Structure - 1画面・1ウィジェット1ファイル厳守
- **Screens** (`lib/screen/`): Full-page views (homescreen, machine_list_screen, machine_detail_screen, inspection_screen)
- **Widgets** (`lib/widget/`): Reusable UI components (machine_card, machine_item_card, attention_item_card, etc.)
- **Theme**: Material 3 design with Google Fonts (Roboto) and blue seed color scheme

### Utilities (`lib/utils/`) - 1機能1ファイル厳守
- **UUID Generation**: Custom UUID generator for entity tracking
- **Constants**: App-wide configuration values

### State Management (`lib/providers/`) - 1機能1プロバイダー厳守
- Riverpod directory exists but is currently empty - intended for state management implementation

## Key Development Patterns

### Model Design
- All models use factory constructors for creation and JSON deserialization
- UUID-based entity tracking with `generateUuid()` utility
- Immutable objects with `copyWith()` methods for updates
- Consistent timestamp tracking (createdAt, updatedAt)

### Maintenance Management
Three-tier maintenance system:
- **Detailed**: Comprehensive tracking (tractors)
- **Simple**: Basic maintenance (combines, planters, cultivators)  
- **Minimal**: Essential maintenance only (attachments)

### Data Relationships
- Machines link to Status entities via `statusUuid`
- Specialized equipment (Tractor) links to base Machine via `machineUuid`
- Dummy data demonstrates relationship patterns for development

## Code Style & Linting

The project uses `package:flutter_lints/flutter.yaml` for code analysis. Key standards:
- Follow Flutter/Dart conventions
- Use descriptive variable names in日本語 where domain-specific
- Maintain consistent formatting with `dart format`
- Run `flutter analyze` before committing changes
- **File size limit: 150 lines per file**

## Testing

- Test files located in `test/` directory
- Run tests with `flutter test`
- Widget tests are the primary testing approach for Flutter UI components

---

## Claude Codeへの追加前提（Claudeへのプロンプトとして活用）

このプロジェクトは、IT未経験からの転職を目的として構築しており、以下の指針に沿ってClaude Codeの支援を期待します：

- **プロジェクト名**: 農機具管理アプリ（Flutter→Django）
- **目的**: 転職用ポートフォリオの構築、SQLとバックエンド学習、副業案件獲得
- **開発方針**:
  - **MVP思考でまず動くものを優先**
  - **1ファイル1機能原則で保守性確保**
  - 完璧主義による実行停止を防ぐため、段階的に実装を進める
  - 不安軽減のため、複数案を提示してから決定したい
- **設計哲学**:
  - **composition-first**（has-a 関係重視、継承より構成）
  - **フォルダ構造**：data / models / providers / screen / widgets
  - **UUIDは v4形式**を採用（`uuid`パッケージ）
  - **150行以下**でファイル分割
- **開発支援方針**:
  - Claudeは曖昧な仕様があれば補完・提案してよい
  - **初学者向けの視点**で理由付きの提案を優先
  - **8月7日MVP完成**がデッドライン