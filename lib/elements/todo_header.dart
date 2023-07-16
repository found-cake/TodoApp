import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/active_todo_count.dart';

class TodoHeader extends StatelessWidget{
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Todo",
          style: TextStyle(
              fontSize: 40
          ),
        ),
        Text(
          "${context.watch<ActiveTodoCount>().state.activeTodoCount} item left",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}