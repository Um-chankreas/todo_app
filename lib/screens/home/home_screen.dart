import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:todo_app/screens/create_task/provider/task_provider.dart';
import 'package:todo_app/screens/create_task/widgets/btn_add.dart';
import 'package:todo_app/screens/create_task/widgets/pie_chat_task.dart';
import 'package:todo_app/screens/create_task/widgets/priority_barchat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TaskProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;
    final upcomingTasks =
        todoProvider.todos.where((t) => !t.isCompleted).toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate))
          ..take(5);
    int completed = todoProvider.todos.where((t) => t.isCompleted).length;
    int overdue = todoProvider.todos
        .where((t) => !t.isCompleted && t.dueDate.isBefore(DateTime.now()))
        .length;
    int timely = todoProvider.todos.length - completed - overdue;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Productivity"),
        actions: [
          Switch(
            padding: const EdgeInsets.all(0),
            value: isDark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todoProvider.summaries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 boxes per row
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5, // width / height ratio
                ),
                itemBuilder: (context, index) {
                  final item = todoProvider.summaries[index];
                  return _buildSummaryCard(
                    item['label'].toString(),
                    int.parse(item['count'].toString()),
                    item['color'] as Color,
                  );
                },
              ),
            ),

            const Gap(16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: TaskPieChart(
                completed: completed,
                timely: timely,
                overdue: overdue,
              ),
            ),
            const Gap(16),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Priority Distribution',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(32),
                  PriorityBarChart(
                    high: todoProvider.todos
                        .where((t) => t.priority == 'High')
                        .length,
                    medium: todoProvider.todos
                        .where((t) => t.priority == 'Medium')
                        .length,
                    low: todoProvider.todos
                        .where((t) => t.priority == 'Low')
                        .length,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upcoming Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Gap(16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upcomingTasks.length,
                    itemBuilder: (context, index) {
                      final task = upcomingTasks[index];
                      return ListTile(
                        leading: Icon(
                          Icons.circle,
                          color: task.priority == 'High'
                              ? Colors.red
                              : task.priority == 'Medium'
                              ? Colors.orange
                              : Colors.green,
                        ),
                        title: Text(task.title),
                        subtitle: Text('Due: ${task.dueDate}'),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (val) {
                            todoProvider.updateTodo(
                              task.copyWith(isCompleted: val ?? false),
                            );
                          },
                        ),
                        onLongPress: () => todoProvider.deleteTodo(task.id),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BtnAdd(),
    );
  }

  Widget _buildSummaryCard(String label, int count, Color color) {
    return Card(
      color: color.withValues(alpha: 0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Gap(4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
