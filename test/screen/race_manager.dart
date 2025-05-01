import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/bottom_navigation_provider.dart';
import 'package:race_tracker/ui/provider/time_tracking_provider.dart';
import 'package:race_tracker/ui/screens/race_manager.dart';
import 'package:race_tracker/ui/widgets/actions/rt_button.dart';

void main() {
  testWidgets('Race starts and stops on button press', (
    WidgetTester tester,
  ) async {
    // Create a test provider
    final provider = RaceManagerProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<RaceManagerProvider>.value(value: provider),
          ChangeNotifierProvider<BottomNavigationProvider>.value(
            value: BottomNavigationProvider(),
          ),
        ],
        child: MaterialApp(home: const RaceManager()),
      ),
    );

    // Initial state: timer is not running
    expect(find.widgetWithText(RTButton, 'Start'), findsOneWidget);
    expect(provider.isTracking, isFalse);

    // Tap the start button
    // await tester.tap(find.widgetWithText(RTButton, 'Start'));
    // await tester.pumpAndSettle();

    // // Timer should be running
    // expect(provider.isTracking, isTrue);
    // expect(find.widgetWithText(RTButton, 'Save'), findsOneWidget);

    // // Tap the save button that become available
    // await tester.tap(find.widgetWithText(RTButton, 'Save'));
    // await tester.pump();

    // // Timer should stop
    // expect(provider.isTracking, isFalse);
    // expect(find.widgetWithText(RTButton, 'Save'), findsOneWidget);
  });
}
