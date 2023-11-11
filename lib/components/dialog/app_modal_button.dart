import 'package:flutter/material.dart';

class DialogModalButton {
  String labelText;
  VoidCallback onPressed;
  Color? color;

  factory DialogModalButton.close(BuildContext context) {
    return DialogModalButton(
      labelText: 'Fechar',
      onPressed: Navigator.of(context).pop,
      color: Colors.black54,
    );
  }

  DialogModalButton({
    required this.labelText,
    required this.onPressed,
    this.color,
  });
}
