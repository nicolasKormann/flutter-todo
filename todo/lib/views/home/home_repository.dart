import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/model/todo.dart';

abstract class HomeRepository {
  Future<bool> createItem(TodoModel todo);
  Future<List<TodoModel>> getItems();
}

class HomeRepositoryHttp implements HomeRepository {
  final baseUrl = 'https://crudcrud.com/api/bb576389aa1e4e4f9ed2fd0bfa87704e';
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
    final todo = list.map((e) => TodoModel.fromMap(e)).toList();
    return todo;
  }
 
}
