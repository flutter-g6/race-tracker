import 'package:flutter/material.dart';

import '../widgets/navigation/rt_nav_bar.dart';
import '../widgets/navigation/rt_top_bar.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(
        title: 'Results',
      ),
      body: Center(child: Text('Result Screen')),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}