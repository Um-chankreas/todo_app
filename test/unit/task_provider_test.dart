import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/databases/app_database.dart';
import 'package:drift/native.dart';
import 'package:todo_app/screens/task/provider/task_provider.dart';

void main() {
  late AppDatabase db;
  late TaskProvider provider;

  setUp(() {
    db = AppDatabase.test(
      NativeDatabase.memory(),
    ); // implement a test constructor
    provider = TaskProvider(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Initial summaries are correct', () {
    expect(provider.summaries.length, 4);
    expect(provider.summaries[0]['label'], 'Total');
    expect(provider.summaries[1]['label'], 'Completed');
  });

  test('Add todo updates summaries', () async {
    await provider.addTodo('Test Task', priority: 'High');

    // Wait a frame to process listeners
    await Future.delayed(Duration.zero);

    expect(provider.todos.length, 1);
    expect(
      provider.summaries.firstWhere((s) => s['label'] == 'Total')['count'],
      1,
    );
    expect(
      provider.summaries.firstWhere(
        (s) => s['label'] == 'High Priority',
      )['count'],
      1,
    );
  });

  test('Delete todo updates summaries', () async {
    await provider.addTodo('Task 1', priority: 'High');
    await Future.delayed(Duration.zero);
    final id = provider.todos.first.id;
    await provider.deleteTodo(id);
    await Future.delayed(Duration.zero);

    expect(provider.todos.length, 0);
    expect(
      provider.summaries.firstWhere((s) => s['label'] == 'Total')['count'],
      0,
    );
  });

  test('getTasksPerDay returns correct count', () async {
    final today = DateTime.now();
    await provider.addTodo('Task 1', dueDate: today);
    await provider.addTodo('Task 2', dueDate: today);
    await Future.delayed(Duration.zero);

    final data = provider.getTasksPerDay();
    final key = "${today.month}/${today.day}";
    expect(data[key], 2);
  });
}
