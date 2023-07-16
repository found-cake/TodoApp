import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/providers.dart';

class CreateTodo extends StatefulWidget{
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: "What to do?"),
      onSubmitted: (value) {
        if(value.trim().isEmpty) return;
        context.read<TodoList>().addTodo(value);
        newTodoController.clear();
      },
    );
  }
}