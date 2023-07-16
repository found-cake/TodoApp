import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/providers/todo_filter.dart';
import 'package:todoapp/providers/todo_list.dart';
import 'package:todoapp/providers/todo_search.dart';

class FilteredTodosState extends Equatable{
  final List<Todo> filteredTodos;

  const FilteredTodosState({
    required this.filteredTodos
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [filteredTodos];

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier{
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;

  void update(TodoFilter filter, TodoSearch todoSearch, TodoList todoList){
    List<Todo> filteredTodos;
    switch(filter.state.filter){
      case Filter.active:
        filteredTodos = todoList.state.todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todoList.state.todos.where((todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoList.state.todos;
        break;
    }

    if(todoSearch.state.searchTerm.isNotEmpty){
      filteredTodos = filteredTodos.where(
        (todo) => todo.desc.toLowerCase().contains(todoSearch.state.searchTerm)
      ).toList();
    }
    _state = _state.copyWith(filteredTodos: filteredTodos);
    notifyListeners();
  }
}