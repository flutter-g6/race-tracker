import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/data/repository/firebase/firebase_result_repository.dart';
import 'package:race_tracker/data/repository/firebase/firebase_segment_tracker_repository.dart';
import 'package:race_tracker/ui/provider/participant_provider.dart';
import 'package:race_tracker/ui/provider/race_tracker_provider.dart';
import 'package:race_tracker/ui/provider/result_provider.dart';

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
        ChangeNotifierProvider(
          create: (_) {
            final raceTrackerProvider = RaceTrackerProvider(
              FirebaseSegmentTrackerRepository(),
              FirebaseRaceRepository(),
            );

            // This function is called here becauase I want it to execute only once
            // Basically, this will establish a stream subscription to the race status
            raceTrackerProvider.init();

            return raceTrackerProvider;
          },
        ),
        ChangeNotifierProvider(
          create:
              (_) => ResultProvider(
                FirebaseResultRepository(),
                FirebaseRaceRepository(),
              ),
        ),
      ],
      child: child,
    );
  }
}
