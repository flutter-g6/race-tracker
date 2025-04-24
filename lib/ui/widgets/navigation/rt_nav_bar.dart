import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/navigation_provider.dart';
import '../../theme/theme.dart';

class RTNavBar extends StatelessWidget {
  const RTNavBar({super.key});

  // Define routes and icons
  static final List<String> _routes = ['/home', '/tracking', '/result'];

  static final List<IconData> _icons = [
    Icons.home,
    Icons.track_changes,
    Icons.score,
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
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
