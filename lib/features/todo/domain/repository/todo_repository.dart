import 'package:dartz/dartz.dart';
import 'package:firebas/core/erorr/fauiler.dart';
import 'package:firebas/features/todo/domain/entity/todo_entity.dart';


abstract class TodoRepository {
  Future<Either<Fauiler, List<TodoEntity>>> writeTodo([
    bool isFinished = false,
  ]);
  Future<Either<Fauiler, Unit>> readTodo(TodoEntity entity);
  Future<Either<Fauiler, Unit>> udpateTodo(TodoEntity entity);
  Future<Either<Fauiler, Unit>> deleteTodo(String id); 
  Future<Either<Fauiler, List<TodoEntity>>> filterTodo(bool isFinished); 
}