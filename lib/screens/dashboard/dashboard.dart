import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/routes/app_route.dart';
import 'package:todo_app/app/routes/app_router.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:todo_app/screens/task/provider/task_provider.dart';
import 'package:todo_app/screens/task/widgets/btn_add.dart';
import 'package:todo_app/screens/task/widgets/pie_chat_task.dart';
import 'package:todo_app/screens/task/widgets/priority_barchat.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;
    final upcomingTasks =
        taskProvider.todos.where((t) => !t.isCompleted).toList()
          ..sort((a, b) {
            int priorityValue(String p) {
              switch (p) {
                case 'High':
                  return 3;
                case 'Medium':
                  return 2;
                case 'Low':
                default:
                  return 1;
              }
            }

            return priorityValue(
              b.priority,
            ).compareTo(priorityValue(a.priority));
          })
          ..take(5);
    int completed = taskProvider.todos.where((t) => t.isCompleted).length;
    int overdue = taskProvider.todos
        .where((t) => !t.isCompleted && t.dueDate.isBefore(DateTime.now()))
        .length;
    int timely = taskProvider.todos.length - completed - overdue;

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
                itemCount: taskProvider.summaries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 boxes per row
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5, // width / height ratio
                ),
                itemBuilder: (context, index) {
                  final item = taskProvider.summaries[index];
                  return _buildSummaryCard(
                    item['label'].toString(),
                    int.parse(item['count'].toString()),
                    item['color'] as Color,
                  );
                },
              ),
            ),
            if (completed > 0 || timely > 0 || overdue > 0) ...[
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
            ],
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
                    high: taskProvider.todos
                        .where((t) => t.priority == 'High')
                        .length,
                    medium: taskProvider.todos
                        .where((t) => t.priority == 'Medium')
                        .length,
                    low: taskProvider.todos
                        .where((t) => t.priority == 'Low')
                        .length,
                  ),
                ],
              ),
            ),
            const Gap(8),
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
                    'Upcoming Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upcomingTasks.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final task = upcomingTasks[index];

                      // Determine due color
                      final now = DateTime.now();
                      final isToday =
                          task.dueDate.year == now.year &&
                          task.dueDate.month == now.month &&
                          task.dueDate.day == now.day;

                      final isOverdue =
                          task.dueDate.isBefore(now) && !task.isCompleted;

                      final dueColor = isOverdue
                          ? Colors.red
                          : isToday
                          ? Colors.yellow.shade700
                          : Colors.grey.shade600;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Open edit screen
                              AppRouter.router.pushNamed(
                                AppRoute.createTask.name,
                                queryParameters: {"id": task.id.toString()},
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Completion checkbox / priority circle
                                InkWell(
                                  onTap: () {
                                    taskProvider.updateTodo(
                                      task.copyWith(
                                        isCompleted: !task.isCompleted,
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      color: task.isCompleted
                                          ? (task.priority == 'High'
                                                ? Colors.red
                                                : task.priority == 'Medium'
                                                ? Colors.orange
                                                : Colors.green)
                                          : Colors.transparent,
                                    ),
                                    child: task.isCompleted
                                        ? Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Task info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          decoration: task.isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: dueColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            DateFormat(
                                              'EEE, MMM d • hh:mm a',
                                            ).format(task.dueDate),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: dueColor,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Optional: rating / progress as small dot
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: task.priority == 'High'
                                                  ? Colors.red
                                                  : task.priority == 'Medium'
                                                  ? Colors.orange
                                                  : Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Delete button
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.grey.shade700,
                                  ),
                                  onPressed: () =>
                                      taskProvider.deleteTodo(task.id),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.shade300),
                        ],
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
    return GestureDetector(
      onTap: () => AppRouter.router.pushNamed(
        AppRoute.taskList.name,
        queryParameters: {"filter": label},
      ),
      child: Card(
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
      ),
    );
  }
}
