import 'package:flutter/material.dart';

class AppButtonTheme {
  static String messageRequired = 'Preenchimento obrigatório.';
  static String numberRequired = 'Digite um número válido';

  static TextStyle get styleTextButton => TextStyle(
    fontSize: 14.0,
    color: Color(Colors.grey[600]!.value),
  );

  static TextStyle styleRaisedButton = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.0,
  );
}
