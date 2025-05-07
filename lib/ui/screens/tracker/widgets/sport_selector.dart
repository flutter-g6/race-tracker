import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';

import 'segmented_control.dart';

class SportSelector extends StatelessWidget {
  const SportSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();
    return RTSegmentedControl(
      selectedSport: provider.selectedSport,
      onSelectionChanged: (sport) {
        provider.setSelectedSport(sport);
      },
    );
  }
}