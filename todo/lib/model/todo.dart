import 'dart:convert';

class TodoModel {
  final String title;
  final String description;
  bool checked;

  TodoModel(
      {required this.title, required this.description, required this.checked});

  Map<String, dynamic> toMap() {
    return {
      'name': title,
      'description': description,
      'checked': checked,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    final model = TodoModel(title: '', description: '', checked: false,
      
    );
    return model;
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  TodoModel copyWith({
    String? title,
    String? description,
    bool? checked,    
  }) {
    return TodoModel(title: '', description: '', checked: false      
    );
  }  
}


