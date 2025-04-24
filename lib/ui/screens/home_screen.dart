import 'package:flutter/material.dart';
import 'package:race_tracker/ui/screens/rt_form.dart';
import 'package:race_tracker/ui/widgets/navigation/rt_top_bar.dart';

import '../widgets/navigation/rt_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RTTopBar(
        title: 'Participants',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const RTForm()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: Text('Home Screen')),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}
