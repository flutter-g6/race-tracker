import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/navigation/rt_top_bar.dart';
import '../../widgets/navigation/rt_tracker_nav_bar.dart';
import 'widgets/participants_display.dart';
import 'widgets/display_mode_selector.dart';

class TrackRunningScreen extends StatelessWidget {
  const TrackRunningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      appBar: const RTTopBar(title: 'Running', centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(RTSpacings.s),
        child: Column(
          children: [
            SizedBox(height: RTSpacings.s),
            DisplayModeSelector(),
            Expanded(child: ParticipantDisplay()),
          ],
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
