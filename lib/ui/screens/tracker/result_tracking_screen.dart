import 'package:flutter/material.dart';

import '../../widgets/navigation/rt_tracker_nav_bar.dart';

class ResultTrackingScreen extends StatelessWidget {
  const ResultTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result Tracking')),
      body: Center(
        child: Text(
          'Result Tracking Screen',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
