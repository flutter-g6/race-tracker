import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/bottom_navigation_provider.dart';
import '../../theme/theme.dart';

class RTTrackerNavBar extends StatelessWidget {
  const RTTrackerNavBar({super.key});

  // Define routes and icons
  static final List<String> _routes = [
    '/swimming',
    '/cycling',
    '/running',
    '/result-tracking-time',
  ];

  static final List<IconData> _icons = [
    Icons.pool,
    Icons.directions_run,
    Icons.directions_bike,
    Icons.check_circle
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);
    final selectedIndex = navigationProvider.selectedIndex;

    return NavigationBar(
      backgroundColor: RTColors.white,
      indicatorColor: RTColors.primary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        navigationProvider.setIndex(index);
        Navigator.pushReplacementNamed(context, _routes[index]);
      },
      destinations: List.generate(
        _icons.length,
        (index) => NavigationDestination(
          icon: Icon(
            _icons[index],
            color: selectedIndex == index ? Colors.white : RTColors.black,
          ),
          selectedIcon: Icon(_icons[index], color: Colors.white),
          label: '',
        ),
      ),
    );
  }
}
