import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

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
  void addTodo(String description) {
    final todo = Todo(description);
    todos.add(todo);
  }

  @action
  void removeTodo(Todo todo) {
    todos.removeWhere((x) => x == todo);
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
