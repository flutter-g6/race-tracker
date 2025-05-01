import 'package:flutter/material.dart';

import '../../theme/theme.dart';

///
/// Icon Button rendering for the whole application
///
class RTIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;

  const RTIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(icon, size: RTSizes.smallIcon, color: RTColors.primary),
      ),
    );
  }
}
