import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class RTDivider extends StatelessWidget {
  const RTDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: RTColors.greyLight);
  }
}
