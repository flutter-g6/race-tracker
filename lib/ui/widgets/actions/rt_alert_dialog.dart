import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RTAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final VoidCallback onYesConfirmed;
  final VoidCallback onNoPressed;

  const RTAlertDialog({
    super.key,
    required this.title,
    this.content,
    required this.onYesConfirmed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: RTColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RTSpacings.radius),
      ),
      title: Text(
        title,
        style: RTTextStyles.heading.copyWith(color: RTColors.black),
      ),
      content: Text(
        content!= null ? '' : content!,
        style: RTTextStyles.body.copyWith(color: RTColors.black),
      ),
      actions: [
        CupertinoButton(
          onPressed: onNoPressed,
          color: RTColors.error,
          padding: const EdgeInsets.symmetric(
            vertical: RTSpacings.s,
            horizontal: RTSpacings.m,
          ),
          child: Text(
            'No',
            style: RTTextStyles.button.copyWith(color: RTColors.white),
          ),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Action confirmed. Undo?',
                  style: RTTextStyles.body.copyWith(color: RTColors.white),
                ),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: RTColors.secondary,
                  onPressed: () {
                    // Perform undo logic here
                  },
                ),
                backgroundColor: RTColors.primary,
              ),
            );
            onYesConfirmed();
          },
          color: RTColors.success,
          padding: const EdgeInsets.symmetric(
            vertical: RTSpacings.s,
            horizontal: RTSpacings.m,
          ),
          child: Text(
            'Yes',
            style: RTTextStyles.button.copyWith(color: RTColors.white),
          ),
        ),
      ],
    );
  }
}
