# CLAUDE.md
必ず日本語で回答してください。

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

### Model Layer (`lib/model/`)
- **Machine**: Base class for all agricultural equipment with UUID tracking, maintenance levels, and JSON serialization
- **MachineType**: Enum defining equipment types (tractor, combine, planter, cultivator, attachment) with associated maintenance levels
- **Status**: Entity status tracking with UUID and timestamps
- **Tractor**: Specialized machine model with hydraulic and tire pressure data
- **MaintenanceRecord** & **WorkRecord**: Track maintenance and operational history

### Data Management (`lib/data/`)
- **MachineDummyData**: Provides test data for development including machines, statuses, and composite data structures
- Contains helper classes like `MachineWithStatus` for UI display
- Includes health status calculation and filtering logic

### UI Layer Structure
- **Screens** (`lib/screen/`): Full-page views (homescreen, machine_list_screen, machine_detail_screen, inspection_screen)
- **Widgets** (`lib/widget/`): Reusable UI components (machine_card, machine_item_card, attention_item_card, etc.)
- **Theme**: Material 3 design with Google Fonts (Roboto) and blue seed color scheme

### Utilities (`lib/utils/`)
- **UUID Generation**: Custom UUID generator for entity tracking
- **Constants**: App-wide configuration values

### State Management
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
- Use descriptive variable names in Japanese where domain-specific
- Maintain consistent formatting with `dart format`
- Run `flutter analyze` before committing changes

## Testing

- Test files located in `test/` directory
- Run tests with `flutter test`
- Widget tests are the primary testing approach for Flutter UI components