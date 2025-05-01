import 'package:flutter/material.dart';

import '../../widgets/navigation/rt_tracker_nav_bar.dart';

class StartTimeScreen extends StatelessWidget {
  const StartTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start Timer')),
      body: Center(
        child: Text(
          'Start Time Screen',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}
