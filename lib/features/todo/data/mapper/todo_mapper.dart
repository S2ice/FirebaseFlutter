import 'package:firebas/features/todo/data/model/todo_model.dart';
import 'package:firebas/features/todo/domain/entity/todo_entity.dart';

extension TodoMapperModel on TodoModel {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      name: name,
      description: description, 
      price: price,
      category: category,
      isCheck: isCheck,
    );
  }
}

extension TodoMapperEntity on TodoEntity {
  TodoModel toModel() {
    return TodoModel(
      id: id,
      name: name,
      description: description, 
      price: price,
      category: category,
      isCheck: isCheck,
    );
  }
}
