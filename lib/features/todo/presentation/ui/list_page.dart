import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';
import 'package:firebas/features/todo/presentation/widget/todo_card.dart';
import 'package:firebas/routes/app_router.dart';
import 'package:firebas/routes/router_utils.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
  heroTag: 'add_button_page_one',
  onPressed: () {
    AppRouter.router.goNamed(Pages.addTodo.screenName);
  },
  child: const Icon(Icons.add),
),
      appBar: AppBar(
        title: Text('Список задач'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              final todoController = context.read<TodoController>();
              todoController.filterTodoList(true); 
            },
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              final todoController = context.read<TodoController>();
              todoController.filterTodoList(false); 
            },
          ),
        ],
      ),
      body: switch (context.select<TodoController, TodoState>((value) => value.state)) {
        TodoState.initial || TodoState.loading => const Center(
          child: CircularProgressIndicator(),
        ),
        TodoState.success => ListView.builder(
          itemCount: context.select<TodoController, int>(
            (value) => value.getTodoList.length,
          ),
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(context.read<TodoController>().getTodoList[index].id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) {
                final todoController = context.read<TodoController>();
                todoController.removeTodo(todoController.getTodoList[index].id); 
              },
              child: TodoCard(
                index: index,
              ),
            );
          },
        ),
        TodoState.error => const Center(
          child: Text('Ошибка'),
        ),
      },
    );
  }
}