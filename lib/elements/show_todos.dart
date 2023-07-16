import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/providers/providers.dart';

class ShowTodos extends StatelessWidget{
  const ShowTodos({super.key});

  Container showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos = context.watch<FilteredTodos>().state.filteredTodos;

    return ListView.separated(
      itemCount: todos.length,
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Divider(
        color: Colors.grey,
        height: 5,
      ),
      itemBuilder: (context, index) {
        final Todo todo = todos[index];
        return Dismissible(
          key: ValueKey(todo.id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) => context.read<TodoList>().removeTodo(todo),
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Aru you sure?"),
                  content: const Text("Do you really want to delete?"),
                  actions: [
                    TextButton(
                      child: const Text("NO"),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: const Text("YES"),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                );
              },
            );
          },
          child: TodoItem(todo: todo,)
        );
      },
    );
  }
}

class TodoItem extends StatefulWidget{
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textController.text = widget.todo.desc;
            
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text("Edit Todo"),
                content: TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    errorText: error ? "Value cannot be empty" : null
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("CANCEL"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        error = textController.text.isEmpty ? true : false;
                        if(!error) {
                          context.read<TodoList>().editTodo(widget.todo.id, textController.text);
                          Navigator.pop(context);
                        }
                      },);
                    },
                    child: const Text("EDIT"),
                  ),
                ],
              );
            },);
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (value) {
          context.read<TodoList>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}