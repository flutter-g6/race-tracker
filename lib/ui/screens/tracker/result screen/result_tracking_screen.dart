import 'package:flutter/material.dart';
import 'package:race_tracker/ui/screens/tracker/result%20screen/leader_board.dart';
import 'package:race_tracker/ui/theme/theme.dart';

import '../../../widgets/display/result_list_tile.dart';
import 'cycle_tracking.dart';
import 'run_tracking.dart';
import 'swim_tracking.dart';
import '../../../widgets/navigation/rt_top_bar.dart';
import '../../../widgets/navigation/rt_tracker_nav_bar.dart';

class ResultTrackingScreen extends StatelessWidget {
  const ResultTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(title: 'Results Tracking', centerTitle: true),
      backgroundColor: RTColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResultListTile(
              title: 'Swimming',
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SwimTracking()),
                );
              },
            ),
            ResultListTile(
              title: 'Cycling',
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const CycleTracking()),
                );
              },
            ),
            ResultListTile(
              title: 'Running',
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const RunTracking()),
                );
              },
            ),
            ResultListTile(
              title: 'Overall Results',
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const LeaderBoard()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
