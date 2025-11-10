import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/utils/app_log.dart';
import 'package:todo_app/databases/app_database.dart';

enum StatusSave { saving, done, none, running }

class TaskProvider extends ChangeNotifier {
  final AppDatabase db;

  TaskProvider(this.db) {
    _init();
  }

  final List<Map<String, dynamic>> summaries = [
    {'label': 'Total', 'count': 0, 'color': Colors.blue},
    {'label': 'Completed', 'count': 0, 'color': Colors.green},
    {'label': 'Pending', 'count': 0, 'color': Colors.orange},
    {'label': 'High Priority', 'count': 0, 'color': Colors.red},
  ];

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  void _init() {
    db.watchTodos().listen((event) {
      _todos = event;
      final int totalTasks = _todos.length;
      final int completedTasks = _todos.where((t) => t.isCompleted).length;
      final int pendingTasks = totalTasks - completedTasks;
      final int highPriorityTasks = _todos
          .where((t) => t.priority == 'High')
          .length;
      for (var sum in summaries) {
        if (sum['label'] == "Total") {
          sum['count'] = totalTasks;
        } else if (sum['label'] == "Completed") {
          sum['count'] = completedTasks;
        } else if (sum['label'] == "Pending") {
          sum['count'] = pendingTasks;
        } else if (sum['label'] == "High Priority") {
          sum['count'] = highPriorityTasks;
        }
      }
      notifyListeners();
    });
  }

  Future<Todo?> fetchTodoById(int id) async {
    return await db.getTodoById(id);
  }

  Future<void> fetchSummaryCard() async {
    try {
      final int totalTasks = _todos.length;
      final int completedTasks = _todos.where((t) => t.isCompleted).length;
      final int pendingTasks = totalTasks - completedTasks;
      final int highPriorityTasks = _todos
          .where((t) => t.priority == 'High')
          .length;
      for (var sum in summaries) {
        if (sum['label'] == "Total") {
          sum['count'] = totalTasks;
        } else if (sum['label'] == "Completed") {
          sum['count'] = completedTasks;
        } else if (sum['label'] == "Pending") {
          sum['count'] = pendingTasks;
        } else if (sum['label'] == "High Priority") {
          sum['count'] = highPriorityTasks;
        }
      }
      notifyListeners();
    } catch (err) {
      AppLog.error(err.toString());
    }
  }

  Map<String, int> getTasksPerDay() {
    final now = DateTime.now();
    Map<String, int> data = {};

    // last 7 days
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dayKey = "${day.month}/${day.day}";
      final count = _todos
          .where(
            (t) =>
                t.dueDate.year == day.year &&
                t.dueDate.month == day.month &&
                t.dueDate.day == day.day,
          )
          .length;
      data[dayKey] = count;
    }
    return data;
  }

  Future<void> addTodo(
    String title, {
    String description = '',
    String priority = 'Low',
    DateTime? dueDate,
  }) async {
    final entry = TodosCompanion.insert(
      title: title,
      description: Value(description),
      priority: Value(priority),
      dueDate: Value(dueDate ?? DateTime.now()),
    );
    await db.insertTodo(entry);
  }

  Future<void> updateTodo(Todo todo) async {
    await db.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    await db.deleteTodo(id);
  }
}
