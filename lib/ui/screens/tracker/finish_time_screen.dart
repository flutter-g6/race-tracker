import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/navigation/rt_top_bar.dart';
import '../../widgets/navigation/rt_tracker_nav_bar.dart';
import 'participants_display.dart';
import 'widgets/display_mode_selector.dart';
import 'widgets/sport_selector.dart';

class FinishTimeScreen extends StatelessWidget {
  const FinishTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      appBar: RTTopBar(title: 'Finish Timer', centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(RTSpacings.s),
        child: Column(
          children: [
            SportSelector(),
            SizedBox(height: RTSpacings.s),
            DisplayModeSelector(),
            Expanded(child: ParticipantDisplay(isStartScreen: false)),
          ],
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
