// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoList _$TodoListFromJson(Map<String, dynamic> json) => TodoList()
  ..todos = const ObservableTodoListConverter()
      .fromJson(json['todos'] as Iterable<Map<String, dynamic>>);

Map<String, dynamic> _$TodoListToJson(TodoList instance) => <String, dynamic>{
      'todos': const ObservableTodoListConverter().toJson(instance.todos),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoList on _TodoList, Store {
  late final _$todosAtom = Atom(name: '_TodoList.todos', context: context);

  @override
  ObservableList<Todo> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<Todo> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  late final _$_TodoListActionController =
      ActionController(name: '_TodoList', context: context);

  @override
  void addTodo(String description) {
    final _$actionInfo =
        _$_TodoListActionController.startAction(name: '_TodoList.addTodo');
    try {
      return super.addTodo(description);
    } finally {
      _$_TodoListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(Todo todo) {
    final _$actionInfo =
        _$_TodoListActionController.startAction(name: '_TodoList.removeTodo');
    try {
      return super.removeTodo(todo);
    } finally {
      _$_TodoListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
