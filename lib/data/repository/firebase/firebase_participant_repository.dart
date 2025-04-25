import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/data/repository/participant_repository.dart';
import 'package:race_tracker/data/dto/participant_dto.dart'; // Import your DTO here

class FirebaseParticipantRepository extends ParticipantRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('participants');

  @override
  Future<List<Participant>> getParticipants() async {
    final snapshot = await _databaseRef.get();
    if (!snapshot.exists) return [];

    final data = snapshot.value as Map<dynamic, dynamic>;
    return data.entries
        .map((entry) => ParticipantDto.fromJson(Map<String, dynamic>.from(entry.value), entry.key))
        .toList();
  }

  @override
  Future<void> addParticipant(Participant participant) async {
    final String id = const Uuid().v4();

    int bib = participant.bib;

    if (bib == 0) {
      final snapshot = await _databaseRef.get();
      int maxBib = 0;

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        for (final value in data.values) {
          final p = Map<String, dynamic>.from(value);
          final existingBib = p['bib'] as int? ?? 0;
          if (existingBib > maxBib) {
            maxBib = existingBib;
          }
        }
      }

      bib = maxBib + 1;
    }

    final Participant newParticipant = participant.copyWith(id: id, bib: bib);
    await _databaseRef.child(id).set(ParticipantDto.toJson(newParticipant));
  }

  @override
  Future<void> updateParticipant(Participant participant) async {
    if (participant.id.isEmpty) throw Exception("Participant ID is required for update");
    await _databaseRef.child(participant.id).set(ParticipantDto.toJson(participant));
  }

  @override
  Future<void> deleteParticipant(String id) async {
    await _databaseRef.child(id).remove();
  }
}
