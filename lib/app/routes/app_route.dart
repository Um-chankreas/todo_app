class AppRoute {
  final String name;
  final String path;
  AppRoute({required this.name, required this.path});
  /*============#Level 1======= */
  static AppRoute welcome = AppRoute(name: 'welcome', path: '/');
  static AppRoute home = AppRoute(name: 'home', path: '/');
  /*============#Level 2======= */
  static AppRoute login = AppRoute(name: 'login', path: 'login');
  static AppRoute signUp = AppRoute(name: 'sign-up', path: 'sign-up');

  /*============#Task======= */
  static AppRoute createTask = AppRoute(
    name: 'create-task',
    path: 'create-task',
  );
}
