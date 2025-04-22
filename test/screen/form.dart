import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:race_tracker/ui/screens/rt_form.dart';

void main() {
  testWidgets('Participant registration smoke test', (WidgetTester tester) async {
    // Render the form
    await tester.pumpWidget(const MaterialApp(home: RTForm()));

    // Enter first name
    final firstNameField = find.byKey(const Key('firstName'));
    await tester.enterText(firstNameField, 'Phourivath');

    // Enter last name
    final lastNameField = find.byKey(const Key('lastName'));
    await tester.enterText(lastNameField, 'Sin');

    // Enter age
    final ageField = find.byKey(const Key('age'));
    await tester.enterText(ageField, '');

    // Choose gender
    final genderField = find.byKey(const Key('gender'));
    await tester.enterText(genderField, '');

    // Tap submit button
    final submitButton = find.byKey(const Key('submitButton'));
    await tester.tap(submitButton);

    // Wait for any animations or validations to complete
    await tester.pumpAndSettle();

    // Expect a success message or navigation (update this based on your implementation)
    expect(find.text('Registration successful'), findsOneWidget);
  });
}
