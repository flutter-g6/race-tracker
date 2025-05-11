import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participant_provider.dart';
import 'package:race_tracker/ui/provider/race_tracker_provider.dart';

import 'data/repository/firebase/firebase_participant_repository.dart';
import 'data/repository/firebase/firebase_race_repository.dart';
import 'ui/provider/bottom_navigation_provider.dart';
import 'ui/provider/participants_tracking_provider.dart';
import 'ui/provider/race_manager_provider.dart';

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
        ChangeNotifierProvider(
          create: (_) => RaceManagerProvider(FirebaseRaceRepository()),
        ),
        ChangeNotifierProvider(create: (_) => ParticipantsTrackingProvider()),
        ChangeNotifierProvider(create: (_) => RaceTrackerProvider()),
      ],
      child: child,
    );
  }
}
