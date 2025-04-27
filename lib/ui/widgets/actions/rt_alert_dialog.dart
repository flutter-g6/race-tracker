import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RTAlertDialog extends StatelessWidget {
  final String title;
  final String? content;

  const RTAlertDialog({super.key, required this.title, this.content});

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
        content ?? '',
        style: RTTextStyles.body.copyWith(color: RTColors.black),
      ),
      actions: [
        CupertinoButton(
          onPressed: () => Navigator.pop(context, false),
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
          onPressed: () => Navigator.pop(context, true),
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
