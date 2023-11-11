import 'package:flutter/material.dart';
import 'package:target_test/components/input/app_text_field.dart';

const LABEL_TEXT_FIELD = 'Usuário';

class AppUserTextField extends StatelessWidget {
  final void Function(String)? onChanged;

  const AppUserTextField({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: LABEL_TEXT_FIELD,
      textCapitalization: TextCapitalization.none,
      prefixIcon: Icons.person,
      onChanged: onChanged,
      onValidator: (String? value) {
        if (value == null || value.isEmpty) {
          return "$LABEL_TEXT_FIELD não pode estar vazio";
        }
        if (value.length > 20) {
          return "$LABEL_TEXT_FIELD não pode ultrapassar 20 caracteres";
        }
        if (value.endsWith(' ')) {
          return "$LABEL_TEXT_FIELD não pode terminar com espaço";
        }
        return null;
      },
    );
  }
}
