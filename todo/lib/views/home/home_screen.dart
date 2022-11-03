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

  void _handleTodoChange(TodoModel todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar novo item'),
          content: SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(label: Text('Título')),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(label: Text('Descrição')),
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
                    setState(() {
                      Navigator.of(context).pop();
                      if (_titleController.text.isEmpty ||
                          _descriptionController.text.isEmpty) {
                        return;
                      }
                      homeController.createItem(
                        TodoModel(
                          _titleController.text,
                          _descriptionController.text,
                          false,
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

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
      body: FutureBuilder<List<TodoModel>>(
        future: homeController.getItems(),
        builder: (context, snapshot) {
          print('SNAPSHOT: $snapshot');
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
      ),
    );
  }
}
