import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebas/features/todo/presentation/controller/todo_controller.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController(); 
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавление цветка"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_keyForm.currentState!.validate()) return;
          final name = _nameController.text;
          final price = double.tryParse(_priceController.text) ?? 0.0;
          final category = _categoryController.text;
          final description = _descriptionController.text; 
          context.read<TodoController>().addTodo(name, price, category, description); 
          Navigator.pop(context);
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле пустое';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле пустое';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Цена',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _categoryController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле пустое';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Категория',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле пустое';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Описание', // Добавлено поле для ввода описания
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
