import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/create_task/widgets/pie_chat_task.dart';
import 'package:todo_app/screens/create_task/widgets/priority_barchat.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/create_task/provider/task_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:todo_app/databases/app_database.dart';
import 'package:drift/native.dart';

void main() {
  late AppDatabase db;
  late TaskProvider taskProvider;
  late ThemeProvider themeProvider;

  setUp(() {
    SharedPreferences.setMockInitialValues({
      'themeMode': true, // or false, depending on your test
    });
    db = AppDatabase.test(
      NativeDatabase.memory(),
    ); // implement a test constructor
    taskProvider = TaskProvider(db);
    themeProvider = ThemeProvider();
  });

  tearDown(() async {
    await db.close();
  });

  Widget createHomeScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>.value(value: taskProvider),
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }

  testWidgets('HomeScreen shows summary cards', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    expect(find.text('Total'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('High Priority'), findsOneWidget);
  });

  testWidgets('HomeScreen shows pie chart and bar chart', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    expect(find.byType(PriorityBarChart), findsOneWidget);
    expect(find.byType(TaskPieChart), findsOneWidget);
  });

  testWidgets('HomeScreen shows upcoming tasks list', (
    WidgetTester tester,
  ) async {
    await taskProvider.addTodo('Test Task', priority: 'High');
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });
}
