import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:target_test/components/input/app_text_field.dart';
import 'package:target_test/components/input/app_text_field_helper.dart';

const LABEL_TEXT_FIELD = 'Senha';

class AppPasswordTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  AppPasswordTextField({
    Key? key,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPasswordVisible,
      builder: (_, value, child) {
        return AppTextField(
          labelText: LABEL_TEXT_FIELD,
          textInputAction: TextInputAction.done,
          onChanged: onChanged,
          inputFormatters: [
            PhoneMaskInputFormatter(),
          ],
          onFieldSubmitted: onFieldSubmitted,
          onValidator: PhoneMaskInputFormatter.onValidator,
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

class PhoneMaskInputFormatter extends TextInputFormatter {
  final translator = RegExp(r'[0-9a-zA-Z]');
  final mask = '00000000000000000000';

  static String? Function(String?) onValidator = (value) {
    if (value == null || value.isEmpty) {
      return "$LABEL_TEXT_FIELD não pode estar vazio";
    }
    if (value.length < 3) {
      return "$LABEL_TEXT_FIELD não pode ter menos que 2 caracteres";
    }
    if (value.length > 20) {
      return "$LABEL_TEXT_FIELD não pode ultrapassar 20 caracteres";
    }
    if (value.endsWith(' ')) {
      return "$LABEL_TEXT_FIELD não pode terminar com espaço";
    }

    return null;
  };

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final String valueMasked = AppTextFieldHelper.applyMask(
      value: newValue.text,
      mask: mask,
      translator: translator,
    );

    return TextEditingValue(
      text: valueMasked,
      selection: TextSelection.collapsed(offset: valueMasked.length),
    );
  }
}
