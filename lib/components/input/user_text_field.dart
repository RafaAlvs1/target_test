import 'package:flutter/material.dart';
import 'package:target_test/components/input/app_text_field.dart';

const LABEL_USER_TEXT_FIELD = 'Usuário';

class AppUserTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? placeholder;
  final void Function(String)? onChanged;
  final String? Function(String?)? onValidator;
  final bool showIcon;
  final bool required;
  final bool readOnly;
  final EdgeInsets? margin;

  const AppUserTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.placeholder,
    this.onChanged,
    this.onValidator,
    this.margin,
    this.showIcon = true,
    this.required = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      margin: margin,
      required: required,
      readOnly: readOnly,
      controller: controller,
      labelText: labelText == null ? LABEL_USER_TEXT_FIELD : (labelText!.isEmpty ? null : labelText),
      textCapitalization: TextCapitalization.none,
      prefixIcon: showIcon ? Icons.person : null,
      onChanged: onChanged,
      onValidator: onValidator ?? (String? value) {
        if (value == null || value.isEmpty) {
          return "$LABEL_USER_TEXT_FIELD não pode estar vazio";
        }
        if (value.length > 20) {
          return "$LABEL_USER_TEXT_FIELD não pode ultrapassar 20 caracteres";
        }
        return null;
      },
    );
  }
}
