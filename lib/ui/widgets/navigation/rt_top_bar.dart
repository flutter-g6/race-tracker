import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class RTTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  const RTTopBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: RTColors.backgroundAccent,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      title: Text(title, style: RTTextStyles.heading),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
