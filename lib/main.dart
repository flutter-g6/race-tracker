import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:race_tracker/ui/screens/role_selection_screen.dart';
import 'package:race_tracker/ui/screens/tracker/finish_time_screen.dart';
import 'package:race_tracker/ui/screens/tracker/result_tracking_screen.dart';

import 'firebase_options.dart';
import 'provider_scope.dart';
import 'ui/screens/manager/home_screen.dart';
import 'ui/screens/manager/result_screen.dart';
import 'ui/screens/manager/race_manager.dart';
import 'ui/screens/tracker/start_time_screen.dart';
import 'ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: RaceTrackerApp()));
}

class RaceTrackerApp extends StatelessWidget {
  const RaceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/home': (context) => const HomeScreen(),
        '/race-manager': (context) => const RaceManager(),
        '/result': (context) => const ResultScreen(),
        '/start-time': (context) => const StartTimeScreen(),
        '/finish-time': (context) => const FinishTimeScreen(),
        '/result-tracking-time': (context) => const ResultTrackingScreen(),
      },
    );
  }
}
