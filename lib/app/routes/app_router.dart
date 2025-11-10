import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/routes/app_route.dart';
import 'package:todo_app/screens/create_task/new_task_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class AppRouter {
  static GoRouter get router => _goRouter;

  static String? routeNavigate;

  static void setRouteNavigate(String route) {
    routeNavigate = route;
  }

  static final _navigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppRoute.home.path,
    observers: [routeObserver],
    navigatorKey: _navigatorKey,
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeScreen()),
        routes: [
          GoRoute(
            path: AppRoute.createTask.path,
            name: AppRoute.createTask.name,
            builder: (context, state) =>
                NewTaskScreen(id: state.uri.queryParameters['id'].toString()),
          ),
        ],
      ),
    ],
  );
}
