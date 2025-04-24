import 'package:flutter/material.dart';

import '../widgets/navigation/rt_nav_bar.dart';
import '../widgets/navigation/rt_top_bar.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(title: 'Race Manager'),
      body: Center(child: Text('Tracking Screen')),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}
