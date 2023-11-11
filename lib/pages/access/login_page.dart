import 'package:flutter/material.dart';
import 'package:target_test/components/button/app_raised_button.dart';
import 'package:target_test/components/button/app_text_button.dart';
import 'package:target_test/components/input/app_password_text_field.dart';
import 'package:target_test/components/input/user_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _password, _email;

  late bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildForm(),
                  const SizedBox(height: 8),
                  _buildSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildPrivacyPolicy(),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppUserTextField(
            onChanged: (String value) => _email = value,
          ),
          AppPasswordTextField(
            onFieldSubmitted: (value) => _submit(),
            onChanged: (String value) => _password = value,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmit() {
    return _loading
        ? Container(
            height: 32,
            width: 32,
            margin: const EdgeInsets.all(16),
            child: const CircularProgressIndicator.adaptive(),
          )
        : LayoutBuilder(builder: (_, constraints) {
            return AppRaisedButton(
              width: 2 * constraints.maxWidth / 5,
              labelText: 'Entrar',
              onPressed: _submit,
            );
          });
  }

  Widget _buildPrivacyPolicy() {
    return SizedBox(
      height: 70.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: _loading
            ? Container()
            : AppTextButton(
                width: double.infinity,
                labelText: "Política de Privacidade",
                onPressed: _privacyPolicy,
              ),
      ),
    );
  }

  _submit() {}

  _privacyPolicy() {}
}
