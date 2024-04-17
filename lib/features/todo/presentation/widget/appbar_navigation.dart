import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';

class AppBarNavigation extends StatelessWidget implements PreferredSizeWidget{
  final Function(int) onOptionSelected;

  AppBarNavigation({required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Товар ${context.watch<TodoController>().getCountUnfinished}'
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _showSnackBar(context, 'Вы выбрали поиск');
          },
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Опция 1'),
              value: 1,
            ),
            PopupMenuItem(
              child: Text('Опция 2'),
              value: 2,
            ),
            PopupMenuItem(
              child: Text('Опция 3'),
              value: 3,
            ),
          ],
          onSelected: (value) {
            if (value == 3) {
              _showAlertDialog(context, 'Вы выбрали опцию 3');
            } else {
              onOptionSelected(value);
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Важное сообщение'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}