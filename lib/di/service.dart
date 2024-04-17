import 'package:firebas/features/todo/domain/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:firebas/features/todo/data/data_source.dart/todo_local_hive.dart';
import 'package:firebas/features/todo/data/repository/todo_repository_impl.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';

final service = GetIt.instance;

Future<void> init() async {
  service.registerLazySingleton(() => TodoController(service()));
  service.registerLazySingleton<TodoLocalHive>(() => TodoLocalHiveImpl());
  service.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      local: service(),
    ),
  );

  await service<TodoLocalHive>().initDb();
}