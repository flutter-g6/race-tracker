import 'package:flutter/material.dart';

import '../../widgets/navigation/rt_manager_nav_bar.dart';
import '../../widgets/navigation/rt_top_bar.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(title: 'Leader Board', centerTitle: true),
      body: Center(child: Text('LeaderBoard Screen')),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}
