import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/routes/app_route.dart';
import 'package:todo_app/app/routes/app_router.dart';
import 'package:todo_app/screens/task/provider/task_provider.dart';
import 'package:todo_app/databases/app_database.dart';
import 'package:todo_app/screens/task/widgets/btn_add.dart';

class ViewTaskList extends StatelessWidget {
  final String filter;
  const ViewTaskList({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    // Apply filtering
    List<Todo> tasks = taskProvider.todos;
    switch (filter) {
      case 'Completed':
        tasks = tasks.where((t) => t.isCompleted).toList();
        break;
      case 'Pending':
        tasks = tasks.where((t) => !t.isCompleted).toList();
        break;
      case 'High Priority':
        tasks = tasks.where((t) => t.priority == 'High').toList();
        break;
      default:
        break; // All
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(filter, style: Theme.of(context).textTheme.titleMedium),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tasks.length,
        separatorBuilder: (_, context) => Divider(color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final task = tasks[index];

          // Determine status
          final now = DateTime.now();
          final isToday =
              task.dueDate.year == now.year &&
              task.dueDate.month == now.month &&
              task.dueDate.day == now.day;
          final isOverdue = task.dueDate.isBefore(now) && !task.isCompleted;

          Color dateColor;
          if (task.isCompleted) {
            dateColor = Colors.green;
          } else if (isOverdue) {
            dateColor = Colors.red;
          } else if (isToday) {
            dateColor = Colors.yellow.shade800;
          } else {
            dateColor = Colors.grey.shade600;
          }

          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: InkWell(
              onTap: () {
                taskProvider.updateTodo(
                  task.copyWith(isCompleted: !task.isCompleted),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: task.priority == 'High'
                        ? Colors.red
                        : task.priority == 'Medium'
                        ? Colors.orange
                        : Colors.green,
                    width: 2,
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
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: dateColor),
                const SizedBox(width: 4),
                Text(
                  DateFormat('EEE, MMM d • hh:mm a').format(task.dueDate),
                  style: TextStyle(color: dateColor),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.grey.shade700),
              onPressed: () => taskProvider.deleteTodo(task.id),
            ),
            onTap: () {
              AppRouter.router.pushNamed(
                AppRoute.createTask.name,
                queryParameters: {'id': task.id.toString()},
              );
            },
          );
        },
      ),
      floatingActionButton: BtnAdd(),
    );
  }
}
