import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/provider/navigation_provider.dart';

class ProviderScope extends StatelessWidget {
  const ProviderScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers goes here
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: child,
    );
  }
}
