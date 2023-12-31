import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:target_test/components/button/app_text_button.dart';
import 'package:target_test/components/container/app_scaffold.dart';
import 'package:target_test/components/dialog/app_alert_modal.dart';
import 'package:target_test/components/dialog/app_modal_button.dart';
import 'package:target_test/components/input/app_text_field.dart';
import 'package:target_test/models/todo/todo_list.dart';
import 'package:target_test/services/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Authentication().currentUser;

    return Provider<TodoList>(
      create: (_) => TodoList(),
      child: AppScaffold(
        bottomNavigationBar: _buildPrivacyPolicy(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Usuário: ${user?.nome}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              const TodoListView(),
              const SizedBox(height: 32.0),
              AddTodo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return SizedBox(
      height: 70.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: AppTextButton(
          width: double.infinity,
          labelText: "Sair",
          onPressed: () {
            Authentication().signOut();
          },
        ),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);

    list.init();

    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        clipBehavior: Clip.hardEdge,
        child: Observer(
          builder: (_) {
            return ListView.builder(
              itemCount: list.todos.length,
              itemBuilder: (_, index) {
                final todo = list.todos[index];
                return Observer(
                  builder: (_) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  todo.description,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  AppAlertModal.open(
                                    context: context,
                                    description: 'Deseja continuar e remover o texto?',
                                    actions: [
                                      DialogModalButton.close(context),
                                      DialogModalButton(
                                        labelText: 'Continuar',
                                        color: Colors.red,
                                        onPressed: () {
                                          list.removeTodo(todo);
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AddTodo extends StatelessWidget {
  final _textController = TextEditingController(text: '');

  AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);

    return AppTextField(
      required: true,
      placeholder: 'Digite seu texto',
      controller: _textController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (String value) {
        if (value.isEmpty) {
          AppAlertModal.open(
            context: context,
            description: 'Texto está vazio',
          );
          return;
        }
        list.addTodo(value);
        _textController.clear();
      },
    );
  }
}
