import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

///
/// Button rendering for the whole application
///
class RTButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const RTButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Compute the rendering
    Color backgroundColor =
        type == ButtonType.primary ? RTColors.primary : RTColors.white;

    BorderSide border =
        type == ButtonType.primary
            ? BorderSide.none
            : BorderSide(color: RTColors.secondary, width: 2);

    Color textColor =
        type == ButtonType.primary ? RTColors.white : RTColors.primary;

    Color iconColor =
        type == ButtonType.primary ? RTColors.white : RTColors.primary;

    // Create the button icon - if any
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, size: RTSizes.smallIcon, color: iconColor));
      children.add(SizedBox(width: RTSpacings.s));
    }

    // Create the button text
    Text buttonText = Text(
      text,
      style: RTTextStyles.button.copyWith(color: textColor),
    );

    children.add(buttonText);

    // Render the button
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RTSpacings.radiusSmall),
          ),
          side: border,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
