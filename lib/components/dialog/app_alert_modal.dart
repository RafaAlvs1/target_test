import 'package:flutter/material.dart';
import 'package:target_test/components/button/app_text_button.dart';
import 'package:target_test/components/dialog/app_modal_button.dart';

class AppAlertModal extends StatelessWidget {
  static open({
    required BuildContext context,
    required String description,
    String? title,
    List<DialogModalButton>? actions,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertModal(
          title: title,
          description: description,
          actions: actions,
        );
      },
    );
  }

  final String? title;
  final String description;
  final List<DialogModalButton>? actions;

  const AppAlertModal({
    Key? key,
    this.title,
    this.actions,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      actionsPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
      actionsOverflowButtonSpacing: 16.0,
      title: title == null ? null : Text(title!),
      content: Text(description),
      actionsOverflowDirection: VerticalDirection.up,
      actions: (actions ?? [DialogModalButton.close(context)])
          .map((e) => _buildButton(e))
          .toList(),
    );
  }

  Widget _buildButton(DialogModalButton button) {
    if (button.color != null) {
      return AppTextButton(
        labelText: button.labelText,
        onPressed: button.onPressed,
        color: button.color,
      );
    }

    return AppTextButton(
      labelText: button.labelText,
      onPressed: button.onPressed,
      color: button.color,
    );
  }
}
