import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/databases/app_database.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:todo_app/screens/create_task/provider/task_provider.dart';

class ProviderScope extends StatelessWidget {
  final Widget child;
  final AppDatabase db;
  const ProviderScope({super.key, required this.child, required this.db});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (context) => TaskProvider(db),
        ),
      ],
      child: child,
    );
  }
}
