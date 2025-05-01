import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'provider_scope.dart';
import 'ui/screens/manager/home_screen.dart';
import 'ui/screens/manager/result_screen.dart';
import 'ui/screens/manager/race_manager.dart';
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/race-manager': (context) => const RaceManager(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}
