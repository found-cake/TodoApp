import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/debounce.dart';

class SearchAndFilterTodo extends StatelessWidget{
  SearchAndFilterTodo({super.key});
  final debounce = Debounce();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: "Search todos",
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(CupertinoIcons.search),
          ),
          onChanged: (value) {
            debounce.run(() => context.read<TodoSearch>().setSearchTerm(value));
          },
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  TextButton filterButton(BuildContext context, Filter filter){
    late final String filterName;

    switch(filter){
      case Filter.all:
        filterName = "All";
        break;
      case Filter.active:
        filterName = "Active";
        break;
      case Filter.completed:
      default:
        filterName = "Completed";
        break;
    }

    return TextButton(
      onPressed: () => context.read<TodoFilter>().changeFilter(filter),
      child: Text(
        filterName,
        style: TextStyle(
          fontSize: 18,
          color: context.watch<TodoFilter>().state.filter == filter
              ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}