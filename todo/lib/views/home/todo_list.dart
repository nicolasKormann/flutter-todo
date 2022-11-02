import 'package:flutter/material.dart';
import 'package:todo/components/todo_item.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/views/home/home_controller.dart';
import 'package:todo/views/home/home_repository.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final controller = HomeController(HomeRepositoryHttp());

  void _handleTodoChange(TodoModel todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TodoModel>>(
      future: controller.getItems(),
      builder: (context, snapshot) {
        if (snapshot.data == null && !snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          const Center(
            child: Text('Ops, deu ruim'),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final item = snapshot.data?[index];
              return TodoItem(todo: item, onTodoChanged: _handleTodoChange);
            });
      },
    );
  }
}
