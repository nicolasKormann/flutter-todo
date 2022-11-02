import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final TodoModel todo;
  final void Function(TodoModel) onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        leading: CircleAvatar(
          child: Text(todo.title[0]),
        ),
        title: Text('${todo.title[0].toUpperCase()}${todo.title.substring(1)}', style: _getTextStyle(todo.checked)),
        subtitle: Text(todo.description, style: _getTextStyle(todo.checked)),
      ),
    );
  }
}
