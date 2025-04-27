import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participant_provider.dart';

import 'data/repository/firebase/firebase_participant_repository.dart';
import 'ui/provider/bottom_navigation_provider.dart';

class ProviderScope extends StatelessWidget {
  const ProviderScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers goes here
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => ParticipantProvider(FirebaseParticipantRepository()),
        ),
      ],
      child: child,
    );
  }
}
