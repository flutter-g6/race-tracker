import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/navigation/rt_top_bar.dart';
import '../../widgets/navigation/rt_tracker_nav_bar.dart';
import 'widgets/participants_display.dart';
import 'widgets/display_mode_selector.dart';
import 'widgets/sport_selector.dart';

class TrackSwimmingScreen extends StatelessWidget {
  const TrackSwimmingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      appBar: RTTopBar(title: 'Swimming', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(RTSpacings.s),
        child: Column(
          children: [
            const SportSelector(),
            const SizedBox(height: RTSpacings.s),
            const DisplayModeSelector(),
            const Expanded(child: ParticipantDisplay(isStartScreen: true)),
          ],
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
