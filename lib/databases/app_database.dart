import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  TextColumn get priority => text().withDefault(Constant('Low'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dueDate => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.test(NativeDatabase super.db);

  @override
  int get schemaVersion => 1;

  // CRUD operations
  Future<List<Todo>> getAllTodos() => select(todos).get();
  Future<Todo?> getTodoById(int id) =>
      (select(todos)..where((t) => t.id.equals(id))).getSingleOrNull();
  Stream<List<Todo>> watchTodos() => select(todos).watch();
  Future<int> insertTodo(TodosCompanion entry) => into(todos).insert(entry);
  Future updateTodo(Todo todo) => update(todos).replace(todo);
  Future deleteTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todo_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
