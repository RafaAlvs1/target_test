import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_test/shared/constant_preferences.dart';

import 'todo.dart';

part 'todo_list.g.dart';

@JsonSerializable()
class TodoList extends _TodoList with _$TodoList {
  TodoList();

  factory TodoList.fromJson(Map<String, dynamic> json) => _$TodoListFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListToJson(this);
}

abstract class _TodoList with Store {
  @observable
  @ObservableTodoListConverter()
  ObservableList<Todo> todos = ObservableList<Todo>();

  @action
  void init() {
    _init();
  }

  @action
  void addTodo(String description) {
    final todo = Todo(description);
    todos.add(todo);
    _save();
  }

  @action
  void removeTodo(Todo todo) {
    todos.removeWhere((x) => x == todo);
    _save();
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTodos = prefs.getString(ConstantPreferences.STORED_TODOS) ?? '{}';
    final list = json.decode(storedTodos);
    if (list is List) {
      todos.clear();
      for(final element in list) {
        todos.add(Todo.fromJson(element));
      }
    }
  }

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      ConstantPreferences.STORED_TODOS,
      json.encode(todos),
    );
  }
}

class ObservableTodoListConverter
    extends JsonConverter<ObservableList<Todo>, Iterable<Map<String, dynamic>>> {
  const ObservableTodoListConverter();

  @override
  ObservableList<Todo> fromJson(Iterable<Map<String, dynamic>> json) =>
      ObservableList.of(json.map(Todo.fromJson));

  @override
  Iterable<Map<String, dynamic>> toJson(ObservableList<Todo> object) =>
      object.map((element) => element.toJson());
}
