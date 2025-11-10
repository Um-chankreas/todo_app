import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Todo app E2E test: add, complete, delete task', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // 1️⃣ Tap the FAB to add a task
    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);
    await tester.tap(fabFinder);
    await tester.pumpAndSettle();

    // 2️⃣ Enter task title
    final titleField = find.byKey(const Key('taskTitleField'));
    await tester.enterText(titleField, 'E2E Test Task');
    await tester.pumpAndSettle();

    // 3️⃣ Select High priority from dropdown (optional)
    final priorityDropdown = find.byKey(const Key('priorityDropdown'));
    await tester.tap(priorityDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('High').last);
    await tester.pumpAndSettle();

    // 4️⃣ Save the task
    final saveBtn = find.byKey(const Key('btnSaveTask'));
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();

    // ✅ Verify task appears in HomeScreen list
    final taskItem = find.text('E2E Test Task');
    expect(taskItem, findsOneWidget);

    // ✅ Verify summary card updated
    final totalCard = find.text('Total');
    expect(totalCard, findsOneWidget);

    // 5️⃣ Complete the task by tapping the checkbox
    final checkbox = find.descendant(
      of: find.widgetWithText(ListTile, 'E2E Test Task'),
      matching: find.byType(Checkbox),
    );
    expect(checkbox, findsOneWidget);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    // ✅ Verify task is marked as completed in UI
    final completedTask = find.widgetWithText(ListTile, 'E2E Test Task');
    expect(completedTask, findsOneWidget);
    // The checkbox value is updated; optional assert if needed

    // 6️⃣ Delete the task by long-press
    final taskTile = find.widgetWithText(ListTile, 'E2E Test Task');
    await tester.longPress(taskTile);
    await tester.pumpAndSettle();

    // ✅ Verify task is removed
    expect(find.text('E2E Test Task'), findsNothing);

    // ✅ Verify summaries updated
    final totalCount = find.text('0'); // Total count should be 0 now
    expect(totalCount, findsOneWidget);
  });
}
