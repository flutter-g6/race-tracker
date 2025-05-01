import 'package:flutter_test/flutter_test.dart';
import 'package:race_tracker/data/repository/firebase/firebase_participant_repository.dart';
import 'package:race_tracker/model/participant.dart';

void main() {
  final FirebaseParticipantRepository repository = FirebaseParticipantRepository();
  late String newId;

  const participant = {
    "firstName": "Rivath",
    "lastName": "Sin",
    "age": 19,
    "gender": "male",
  };

  const updatedParticipant = {
    "firstName": "Phourivath",
    "lastName": "Sin",
    "age": 20,
    "gender": "male",
  };

  group("Databse CRUD test for participant", () {
    setUp(() async {
      Participant storedParticipant = await repository.store(participant);
      newId = storedParticipant.id;
    });

    test('Read all participants', () async {
      expect(repository.index(), completes);
    });

    test('Create a participant', () async {
      expect(await repository.index(), equals(participant));
    });

    test("Update participant info", () async {
      repository.update(newId, updatedParticipant);

      expect(await repository.index(), equals(updatedParticipant));
      expect(await repository.index(), isNot(equals(participant)));
    });

    test("Delete a participant", () async {
      repository.delete(newId);
      expect(repository.index(), isNot(equals(updatedParticipant)));
    });
  });
}
