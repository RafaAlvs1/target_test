import 'package:flutter/material.dart';
import 'package:target_test/components/input/app_text_field.dart';

class AppPasswordTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? onValidator;

  AppPasswordTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.placeholder,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onValidator,
  }) : super(key: key);

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPasswordVisible,
      builder: (_, value, child) {
        return AppTextField(
          controller: controller,
          labelText: labelText ?? 'Senha',
          placeholder: placeholder,
          textInputAction: textInputAction ?? (onFieldSubmitted != null ? TextInputAction.done : null),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onValidator: onValidator ??
              (String? value) {
                if (value == null || value.isEmpty) {
                  return "Senha não pode estar vazio";
                }
                return null;
              },
          obscureText: !value,
          prefixIcon: Icons.lock_rounded,
          suffixIcon: IconButton(
            icon: Icon(value ? Icons.visibility : Icons.visibility_off),
            onPressed: () => _isPasswordVisible.value = !value,
          ),
        );
      },
    );
  }
}
