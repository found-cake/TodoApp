import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/todos_page.dart';
import 'package:todoapp/providers/providers.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update: (context, todoList, activeTodoCount) => activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          create: (context) => FilteredTodos(),
          update: (context, filter, todoSearch, todoList, filteredTodos) => filteredTodos!..update(filter, todoSearch, todoList),
        ),
      ],
      child: MaterialApp(
        title: "TODOS",
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: const TodoPage(),
      ),
    );
  }
}