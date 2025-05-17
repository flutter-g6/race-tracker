import 'package:flutter/material.dart';

import '../../widgets/navigation/rt_top_bar.dart';
import '../../widgets/navigation/rt_tracker_nav_bar.dart';

class TrackCyclingScreen extends StatelessWidget {
  const TrackCyclingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(
        title: 'Cycling',
        centerTitle: true,
      ),
      body: Center(child: Text('LeaderBoard Screen')),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}