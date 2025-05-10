import 'package:flutter/material.dart';
import 'package:race_tracker/ui/theme/theme.dart';

import 'rt_list_tile.dart';

class ResultListTile extends StatelessWidget {
  final String title;
  final IconData trailingIcon;
  final VoidCallback onTap;

  const ResultListTile({
    required this.title,
    required this.trailingIcon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: RTSpacings.m,
        vertical: RTSpacings.s,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: RTColors.secondary,
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
        child: RTListTile(
          title: title,
          trailingIcon: trailingIcon,
          onTap: onTap,
        ),
      ),
    );
  }
}
