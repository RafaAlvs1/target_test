import 'package:flutter/material.dart';

import 'button_theme.dart';

class AppRaisedButton extends StatelessWidget {
  final double? width;
  final String? labelText;
  final Icon? icon;
  final VoidCallback? onPressed;
  final Color? color;
  final bool loading;

  const AppRaisedButton({
    Key? key,
    this.width,
    this.labelText,
    this.onPressed,
    this.icon,
    this.color,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: loading
          ? Container(
              width: 32.0,
              height: 32.0,
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                backgroundColor: color,
                shape: const StadiumBorder(),
              ),
              child: _buildChild(),
            ),
    );
  }

  Widget? _buildChild() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) _buildWithIcon(icon!),
        if (labelText != null) _buildText(labelText!),
      ],
    );
  }

  _buildWithIcon(Icon icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 4.0),
      ],
    );
  }

  Widget _buildText(String labelText) {
    return Text(
      labelText,
      style: AppButtonTheme.styleRaisedButton,
    );
  }
}
