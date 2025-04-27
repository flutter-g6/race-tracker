import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RTListTile extends StatelessWidget {
  final Widget? leading;
  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  const RTListTile({
    super.key,
    this.leading,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailingIcon,
    this.onTap,
    this.contentPadding,
  }) : assert(
         leading == null || leadingIcon == null,
         'Cannot provide both leading and leadingIcon',
       );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          leading ??
          (leadingIcon != null
              ? Icon(leadingIcon, color: RTColors.primary, size: RTSizes.icon)
              : null),
      title: Text(
        title,
        style: RTTextStyles.subHeading.copyWith(color: RTColors.black),
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
              ? Icon(trailingIcon, color: RTColors.black, size: RTSizes.icon)
              : null,
      onTap: onTap,
      tileColor: RTColors.backgroundAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RTSpacings.radius),
      ),
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(
            vertical: RTSpacings.s,
            horizontal: RTSpacings.m,
          ),
    );
  }
}
