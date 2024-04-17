import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final todoEntity = context.watch<TodoController>().getTodoList[index]; 

    return Card(
      child: ExpansionTile(
        title: Text(todoEntity.name),
        leading: Checkbox(
          value: todoEntity.isCheck,
          onChanged: (value) => context.read<TodoController>().onChangedIsCheck(
            value!,
            index,
          ),
        ),
        children: [
          Text("Цена: \$${todoEntity.price}"),
          Text("Категория: ${todoEntity.category}"),
        ],
      ),
    );
  }
}
