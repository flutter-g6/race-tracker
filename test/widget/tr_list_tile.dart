import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:race_tracker/ui/widgets/display/rt_list_tile.dart';

void main() {
  testWidgets('RTListTile displays title and subtitle correctly', (
    WidgetTester tester,
  ) async {
    // Prepare text
    const titleText = 'Test Title';
    const subtitleText = 'Test Subtitle';

    // Create the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RTListTile(
            title: titleText,
            subtitle: subtitleText,
            leadingIcon: Icons.star,
            trailingIcon: Icons.arrow_forward,
          ),
        ),
      ),
    );

    // Check if the widget created properly
    expect(find.text(titleText), findsOneWidget);
    expect(find.text(subtitleText), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });

  testWidgets('RTListTile triggers onTap callback when tapped', (
    WidgetTester tester,
  ) async {
    // Prepare check
    bool tapped = false;

    // Create the widget with a callback
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RTListTile(
            title: 'Tap me',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Tap the widget
    await tester.tap(find.byType(RTListTile));
    await tester.pumpAndSettle();

    // Check if tapped
    expect(tapped, isTrue);
  });
}
