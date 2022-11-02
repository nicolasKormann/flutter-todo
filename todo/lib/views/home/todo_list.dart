import 'package:flutter/material.dart';
import 'package:todo/components/todo_item.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/views/home/home_controller.dart';
import 'package:todo/views/home/home_repository.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final controller = HomeController(HomeRepositoryHttp());

  final List<TodoModel> _todos = <TodoModel>[];

  void _handleTodoChange(TodoModel todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getItems(),
      builder: ((context, snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: _todos.map((TodoModel todo) {
              return TodoItem(
                todo: todo,
                onTodoChanged: _handleTodoChange,
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const SizedBox(
            width: 60,
            height: 80,
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
