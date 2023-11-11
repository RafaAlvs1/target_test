import 'package:flutter/material.dart';

import 'button_theme.dart';

class AppTextButton extends StatelessWidget {
  final String labelText;
  final double? width;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? padding;

  const AppTextButton({
    Key? key,
    required this.labelText,
    this.width,
    this.onPressed,
    this.color,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: AppButtonTheme.styleTextButton.merge(TextStyle(
            color: color,
          )),
        ),
      ),
    );
  }
}
