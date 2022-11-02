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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final homeController = HomeController(HomeRepositoryHttp());

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar novo item'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Título'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Descrição'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Adicionar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_titleController.text.isEmpty ||
                        _descriptionController.text.isEmpty) {
                      return;
                    }
                    homeController.createItem(TodoModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        checked: false));

                    /* _addTodoItem(
                        _titleController.text, _descriptionController.text); */
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /* void _addTodoItem(String name, String description) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }
    setState(() {
      _todos.add(
          TodoModel(title: name, description: description, checked: false));
    });
    _titleController.clear();
    _descriptionController.clear();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('To-do List'),
      ),
      body: TodoList(),
    );
  }
}
