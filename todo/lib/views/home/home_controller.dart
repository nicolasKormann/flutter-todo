import 'package:todo/model/todo.dart';
import 'package:todo/views/home/home_repository.dart';

class HomeController {
  final HomeRepository homeRepository;

  HomeController(this.homeRepository);


  Future<void> createItem(TodoModel item) async {
    final result = await homeRepository.createItem(item);
    print(result);
  }

  Future<List<TodoModel>> getItems() async {
    final result = await homeRepository.getItems();
    return result;
  }
}