import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/data/repository/participant_repository.dart';
import 'package:race_tracker/data/dto/participant_dto.dart';

class FirebaseParticipantRepository extends ParticipantRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child(
    'participants',
  );
  final DatabaseReference _counterRef = FirebaseDatabase.instance.ref(
    'bibCounter',
  );

  @override
  Future<List<Participant>> getParticipants() async {
    final snapshot = await _databaseRef.get();
    if (!snapshot.exists) return [];

    final data = snapshot.value as Map<dynamic, dynamic>;
    return data.entries
        .map(
          (entry) => ParticipantDto.fromJson(
            Map<String, dynamic>.from(entry.value),
            entry.key,
          ),
        )
        .toList();
  }

  @override
  Future<void> addParticipant(Participant participant) async {
    String bib = participant.bib;
    if (bib.isEmpty) {
      final result = await _counterRef.runTransaction((currentData) {
        int current = (currentData as int?) ?? 0;
        return Transaction.success(current + 1);
      });

      final newBib = result.snapshot.value as int;
      bib = newBib.toString();
    }

    final newRef = _databaseRef.push();
    final Participant newParticipant = participant.copyWith(
      id: newRef.key!,
      bib: bib,
    );

    await newRef.set(ParticipantDto.toJson(newParticipant));
  }

  @override
  Future<void> updateParticipant(Participant participant) async {
    if (participant.id.isEmpty) {
      throw Exception("Participant ID is required for update");
    }
    await _databaseRef
        .child(participant.id)
        .set(ParticipantDto.toJson(participant));
  }

  @override
  Future<void> deleteParticipant(String id) async {
    await _databaseRef.child(id).remove();
  }

  @override
  Future<void> restoreParticipant(Participant participant) async {
    // Just set it back at the same Firebase ID (key)
    await _databaseRef
        .child(participant.id)
        .set(ParticipantDto.toJson(participant));
  }

  Future<Participant?> getParticipantByBib(String bib) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('participants');

    final snapshot = await ref.orderByChild('bib').equalTo(bib).once();

    if (snapshot.snapshot.exists) {
      // Assuming bib is unique, return the first matched participant
      final data = snapshot.snapshot.value as Map;
      final participantEntry = data.entries.first;
      final participant = Map<String, dynamic>.from(participantEntry.value);
      return ParticipantDto.fromJson(participant, participantEntry.key);
    } else {
      return null; // No participant found
    }
  }
}
