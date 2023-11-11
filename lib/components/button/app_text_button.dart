import 'package:flutter/material.dart';

import 'button_theme.dart';

class AppTextButton extends StatelessWidget {
  final String labelText;
  final double? width;
  final VoidCallback? onPressed;

  const AppTextButton({
    Key? key,
    required this.labelText,
    this.width,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: AppButtonTheme.styleTextButton,
        ),
      ),
    );
  }
}
