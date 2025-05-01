import 'package:flutter/material.dart';

import '../../widgets/navigation/rt_tracker_nav_bar.dart';

class FinishTimeScreen extends StatelessWidget {
  const FinishTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finish Timer')),
      body: Center(
        child: Text(
          'Finish Time Screen',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: const RTTrackerNavBar(),
    );
  }
}