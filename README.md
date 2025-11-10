# Todo App

A simple productivity app written in Flutter to track tasks with priorities, summaries, and charts.

## Features
- Add, update, and delete tasks
- Summary cards (Total, Completed, Pending, High Priority)
- Pie chart for task completion
- Bar chart for task priority
- Dark mode support

## Requirements
- Flutter latest stable
- Dart >= 3.0

## Testing
- Unit tests: `flutter test`
- Integration tests: `flutter test integration_test/app_test.dart`

## CI/CD
- GitHub Actions workflow included (`.github/workflows/ci.yml`)
- Runs tests and builds APK on push and PR to `main`

## How to Run
```bash
flutter pub get
flutter run
