import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/model/todo.dart';

abstract class HomeRepository {
  Future<bool> createItem(TodoModel todo);
  Future<List<TodoModel>> getItems();
}

class HomeRepositoryHttp implements HomeRepository {
  final baseUrl = 'https://crudcrud.com/api/0b0184d969804a3f9922995a0718492a';
  @override
  Future<bool> createItem(TodoModel todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/items'),
      body: todo.toJson(),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print(response.statusCode);
    return true;
  }

  @override
  Future<List<TodoModel>> getItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/items'),
    );
    final list = List.from(jsonDecode(response.body));
    print(list);
    final todo = list.map((e) => TodoModel.fromMap(e)).toList();
    return todo;
  }
}
