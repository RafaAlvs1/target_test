import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:target_test/components/input/input_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? onValidator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool? obscureText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool? enabled;
  final AutovalidateMode? autovalidate;
  final int? maxLines;
  final bool required;
  final bool readOnly;
  final EdgeInsets? margin;
  final bool defaultBorder;

  const AppTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.placeholder,
    this.keyboardType,
    this.onValidator,
    this.onChanged,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onTap,
    this.enabled,
    this.autovalidate,
    this.maxLines = 1,
    this.required = true,
    this.readOnly = false,
    this.margin,
    this.defaultBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                labelText!,
                style: InputTheme.labelStyle,
              ),
            ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            obscureText: obscureText ?? false,
            inputFormatters: inputFormatters,
            onTap: onTap,
            readOnly: readOnly || onTap != null,
            autovalidateMode: autovalidate,
            maxLines: maxLines,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: defaultBorder
                  ? null
                  : OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
              errorBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorMaxLines: 2,
              suffixIcon: _buildIcon(suffixIcon),
              prefixIcon: _buildIcon(prefixIcon),
              enabled: enabled ?? true,
            ),
            validator: !required
                ? null
                : (onValidator ??
                    (value) => (value?.isEmpty ?? true) ? InputTheme.messageRequired : null),
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ],
      ),
    );
  }

  Widget? _buildIcon(dynamic icon) {
    if (icon == null) {
      return null;
    }

    if (icon.runtimeType == IconData) {
      return Icon(
        icon,
        size: 20.0,
        color: Colors.black87,
      );
    }

    if (icon.runtimeType == IconButton) {
      final iconButton = icon as IconButton;
      return IconButton(
        icon: Icon(
          (iconButton.icon as Icon).icon,
          size: 20.0,
          color: Colors.black87,
        ),
        onPressed: iconButton.onPressed,
      );
    }

    if (icon is! Widget) {
      return null;
    }

    return Material(
      color: Colors.transparent,
      child: icon,
    );
  }
}
