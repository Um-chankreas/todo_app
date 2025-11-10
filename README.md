# Todo App

A simple productivity app written in Flutter to track tasks with priorities, summaries, and charts.

## Features
- Add, update, and delete tasks
- Summary cards (Total, Completed, Pending, High Priority)
- Pie chart for task completion
- Bar chart for task priority
- Upcomming task filter by priority level
- Dark mode support

## Requirements
- Flutter version 3.35.7 (stable)
- Dart >= 3.0

## Testing
- Unit tests: `flutter test`
- Integration tests: `flutter test integration_test/app_test.dart`

## CI/CD
- GitHub Actions workflow included (`.github/workflows/ci.yml`)
- Runs tests and builds APK on push and PR to `main`

## Installation
```bash
git clone git@github.com:Um-chankreas/todo_app.git
cd todo_app
flutter pub get
flutter run

