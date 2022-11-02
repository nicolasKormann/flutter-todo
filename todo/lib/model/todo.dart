import 'dart:convert';

class TodoModel {
  final String title;
  final String description;
  bool checked;

  TodoModel(
    this.title,
    this.description,
    this.checked,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'checked': checked,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    final model = TodoModel(
      map['title'] ?? '',
      map['description'] ?? '',
      map['checked'] ?? '',
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
    return TodoModel(
      title ?? this.title,
      description ?? this.description,
      checked ?? this.checked,
    );
  }
}
