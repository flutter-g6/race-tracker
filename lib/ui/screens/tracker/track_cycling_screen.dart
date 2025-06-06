import 'package:flutter/material.dart';

import '../../../model/segment_record.dart';
import '../../theme/theme.dart';
import '../../widgets/navigation/rt_top_bar.dart';
import '../../widgets/navigation/rt_tracker_nav_bar.dart';
import 'widgets/display_mode_selector.dart';
import 'widgets/participants_display.dart';

class TrackCyclingScreen extends StatelessWidget {
  const TrackCyclingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      appBar: const RTTopBar(title: 'Cycling', centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(RTSpacings.s),
        child: Column(
          children: [
            SizedBox(height: RTSpacings.s),
            DisplayModeSelector(),
            Expanded(child: ParticipantDisplay(segment: Segment.cycle)),
          ],
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
