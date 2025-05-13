import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';

import '../../../theme/theme.dart';
import '../../../widgets/actions/rt_button.dart';

enum DisplayMode { list, grid, massStart }

class DisplayModeSelector extends StatelessWidget {
  const DisplayModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();
    
    return Row(
      children: [
        RTButton(
          text: 'List',
          icon: Icons.list,
          type: provider.displayMode == DisplayMode.list
              ? ButtonType.primary
              : ButtonType.secondary,
          onPressed: () => provider.setDisplayMode(DisplayMode.list),
        ),
        const SizedBox(width: RTSpacings.s),
        RTButton(
          text: 'Grid',
          icon: Icons.grid_view,
          type: provider.displayMode == DisplayMode.grid
              ? ButtonType.primary
              : ButtonType.secondary,
          onPressed: () => provider.setDisplayMode(DisplayMode.grid),
        ),
        const SizedBox(width: RTSpacings.s),
        RTButton(
          text: 'Mass Start',
          icon: Icons.start,
          type: provider.displayMode == DisplayMode.massStart
              ? ButtonType.primary
              : ButtonType.secondary,
          onPressed: () => provider.setDisplayMode(DisplayMode.massStart),
        ),
      ],
    );
  }
}