import 'package:flutter/material.dart';
import 'package:todoapp/elements/create_todo.dart';
import 'package:todoapp/elements/search_filter_todo.dart';
import 'package:todoapp/elements/show_todos.dart';

import '../elements/todo_header.dart';

class TodoPage extends StatefulWidget{
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(height: 20,),
                SearchAndFilterTodo(),
                const ShowTodos(),
              ],
            )
          )
        )
      ),
    );
  }
}