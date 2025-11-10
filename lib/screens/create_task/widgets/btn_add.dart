import 'package:flutter/material.dart';
import 'package:todo_app/app/routes/app_route.dart';
import 'package:todo_app/app/routes/app_router.dart';

class BtnAdd extends StatelessWidget {
  const BtnAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.router.pushNamed(AppRoute.createTask.name),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
