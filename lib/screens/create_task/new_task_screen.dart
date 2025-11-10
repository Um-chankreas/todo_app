import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/enum/priority_type.dart';
import 'package:todo_app/databases/app_database.dart';
import 'package:todo_app/screens/create_task/provider/task_provider.dart';

class NewTaskScreen extends StatefulWidget {
  final String? id;
  const NewTaskScreen({super.key, this.id});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController taskTitle = TextEditingController();
  TextEditingController description = TextEditingController();
  PriorityLevel priorityLevel = PriorityLevel.low;
  DateTime? _dueDate;
  Todo? todo;

  List<PriorityLevel> priorityLevels = [
    PriorityLevel.high,
    PriorityLevel.medium,
    PriorityLevel.low,
  ];

  void _updatePriority(PriorityLevel level) {
    setState(() {
      priorityLevel = level;
    });
  }

  Future<void> _saveTask() async {
    final title = taskTitle.text.trim();
    if (taskTitle.text.isEmpty && description.text.isEmpty) {
    } else {
      if (todo != null) {
        // Update existing todo
        final updatedTodo = todo!.copyWith(
          title: title,
          description: drift.Value(description.text),
          priority: priorityLevel.label,
          dueDate: _dueDate,
        );
        await context.read<TaskProvider>().updateTodo(updatedTodo);
      } else {
        await context.read<TaskProvider>().addTodo(
          title,
          description: description.text,
          priority: priorityLevel.label,
          dueDate: _dueDate,
        );
      }
    }
  }

  Future<void> getTodo() async {
    if (widget.id != "null") {
      todo = await context.read<TaskProvider>().fetchTodoById(
        int.parse(widget.id.toString()),
      );
      if (todo != null) {
        taskTitle.text = todo!.title;
        description.text = todo!.description ?? '';
        priorityLevel = PriorityLevel.values.firstWhere(
          (p) => p.label == todo!.priority,
          orElse: () => PriorityLevel.low,
        );
        _dueDate = todo!.dueDate;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _saveTask();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.done, color: Theme.of(context).primaryColor),
              ),
              const Gap(16),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            await _saveTask();
                          }
                        },
                        child: TextFormField(
                          controller: taskTitle,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Task title',
                            hintStyle: Theme.of(context).textTheme.titleLarge,
                            border: InputBorder.none, // remove all borders
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 0,
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade300),
                      TextFormField(
                        controller: description,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Your note here',
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                          border: InputBorder.none, // remove all borders
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Priority",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(8),
                      Row(
                        children: priorityLevels
                            .map(
                              (p) => Expanded(
                                child: GestureDetector(
                                  onTap: () => _updatePriority(p),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: priorityLevel == p
                                          ? p.color
                                          : null,
                                      border: priorityLevel == p
                                          ? null
                                          : Border.all(color: p.color),
                                    ),

                                    child: Text(
                                      p.label,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: p == priorityLevel
                                                ? Colors.white
                                                : p.color,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due Date & Time",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: _pickDueDateTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                                color: Colors.red,
                              ),
                              const Gap(8),
                              Text(
                                _dueDate == null
                                    ? 'Select date & time'
                                    : DateFormat(
                                        'EEE, MMM d • hh:mm a',
                                      ).format(_dueDate!),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: _dueDate == null
                                          ? Colors.grey
                                          : Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDueDateTime() async {
    final now = DateTime.now();

    // Pick date
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    // Pick time
    TimeOfDay? pickedTime;
    if (mounted) {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: _dueDate != null
            ? TimeOfDay.fromDateTime(_dueDate!)
            : TimeOfDay.now(),
      );
    }

    if (pickedTime == null) return;

    final combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _dueDate = combined;
    });
  }
}
