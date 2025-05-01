import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/ui/provider/async_value.dart';
import 'package:race_tracker/ui/provider/participant_provider.dart';
import 'package:race_tracker/ui/screens/rt_form.dart';
import 'package:race_tracker/ui/widgets/actions/rt_button.dart';

class MockParticipantProvider extends ChangeNotifier
    implements ParticipantProvider {
  bool addCalled = false;
  bool updateCalled = false;
  late Participant lastParticipant;

  @override
  void addParticipant(Participant p) {
    addCalled = true;
    lastParticipant = p;
  }

  @override
  void updateParticipant(Participant p) {
    updateCalled = true;
    lastParticipant = p;
  }

  ///
  /// Below overide aren't use for testing here
  ///
  @override
  AsyncValue<List<Participant>>? participantState;

  @override
  void deleteParticipant(String id) {}

  @override
  void fetchParticipant() {}

  @override
  bool get hasData => throw UnimplementedError();

  @override
  bool get isLoading => throw UnimplementedError();
}

void main() {
  testWidgets('RTForm saves valid participant data on Add', (
    WidgetTester tester,
  ) async {
    final mockProvider = MockParticipantProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ParticipantProvider>.value(
        value: mockProvider,
        child: MaterialApp(home: RTForm(title: 'Add Participant')),
      ),
    );

    // Enter participant info
    await tester.enterText(find.bySemanticsLabel('First Name'), 'Phourivath');
    await tester.enterText(find.bySemanticsLabel('Last Name'), 'Sin');
    await tester.enterText(find.bySemanticsLabel('Age'), '20');

    // Open and select dropdown gender
    await tester.tap(find.byKey(Key('genderDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Male').last);
    await tester.pumpAndSettle();

    // Tap the Add button
    await tester.tap(find.widgetWithText(RTButton, "Add"));
    await tester.pumpAndSettle();

    // Expect new participant added
    expect(mockProvider.addCalled, isTrue);
    expect(mockProvider.lastParticipant.firstName, equals('Phourivath'));
    expect(mockProvider.lastParticipant.lastName, equals('Sin'));
    expect(mockProvider.lastParticipant.age, equals(20));
    expect(mockProvider.lastParticipant.gender, equals('Male'));
  });

  testWidgets('RTForm shows validation errors on invalid input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ParticipantProvider>.value(
        value: MockParticipantProvider(),
        child: const MaterialApp(home: RTForm(title: 'Add Participant')),
      ),
    );

    // Tap Add without filling any fields
    await tester.tap(find.widgetWithText(RTButton, "Add"));
    await tester.pump();

    // Expect validation error messages
    expect(find.text('Must be between 1 and 20 characters.'), findsNWidgets(2));
    expect(find.text('Enter a valid age (12-59).'), findsOneWidget);
    expect(find.text('Please select a gender.'), findsOneWidget);
  });
}
