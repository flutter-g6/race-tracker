import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class RTNavBar extends StatefulWidget {
  const RTNavBar({super.key});

  @override
  State<RTNavBar> createState() => _RTNavBarState();
}

class _RTNavBarState extends State<RTNavBar> {
  // Define routes and icons
  static final List<String> _routes = ['/home', '/tracking', '/result'];

  static final List<IconData> _icons = [
    Icons.home,
    Icons.track_changes,
    Icons.score,
  ];

  // Keep track of the selected index
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the selected route
    Navigator.pushNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: RTColors.white,
      indicatorColor: RTColors.primary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onDestinationSelected,
      destinations: List.generate(
        _icons.length,
        (index) => NavigationDestination(
          icon: Icon(
            _icons[index],
            color: _selectedIndex == index ? Colors.white : RTColors.black,
          ),
          selectedIcon: Icon(_icons[index], color: Colors.white),
          label: '',
        ),
      ),
    );
  }
}
