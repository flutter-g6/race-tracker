import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RTListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  const RTListTile({
    super.key,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          leadingIcon != null
              ? Icon(leadingIcon, color: RTColors.primary, size: RTSizes.icon)
              : null,
      title: Text(
        title,
        style: RTTextStyles.heading.copyWith(color: RTColors.black),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: RTTextStyles.body.copyWith(color: RTColors.greyLight),
              )
              : null,
      trailing:
          trailingIcon != null
              ? Icon(
                trailingIcon,
                color: RTColors.secondary,
                size: RTSizes.icon,
              )
              : null,
      onTap: onTap,
      tileColor: RTColors.backgroundAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RTSpacings.radius),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: RTSpacings.s,
        horizontal: RTSpacings.m,
      ),
    );
  }
}
