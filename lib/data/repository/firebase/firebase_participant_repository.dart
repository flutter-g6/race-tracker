import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/data/repository/participant_repository.dart';
import 'package:race_tracker/data/dto/participant_dto.dart'; // Import your DTO here

class FirebaseParticipantRepository extends ParticipantRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child(
    'participants',
  );

  @override
  Future<List<Participant>> getParticipants() async {
    final snapshot = await _databaseRef.get();
    if (!snapshot.exists) return [];

    final data = snapshot.value as Map<dynamic, dynamic>;
    List<Participant> participants = data.entries
      .map(
        (entry) => ParticipantDto.fromJson(
          Map<String, dynamic>.from(entry.value),
          entry.key,
        ),
      )
      .toList();

    participants.sort((a, b) {
      final bibA = int.tryParse(a.bib) ?? 0;
      final bibB = int.tryParse(b.bib) ?? 0;
      return bibA.compareTo(bibB);
    });

    return participants;
  }

  @override
  Future<void> addParticipant(Participant participant) async {
    final String id = const Uuid().v4();

    String bib = participant.bib;
    if (bib.isEmpty) {
      final snapshot = await _databaseRef.get();
      int maxBib = 0;

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        for (final value in data.values) {
          final p = Map<String, dynamic>.from(value);
          final existingBibStr = p['bib']?.toString() ?? '0';
          final existingBib = int.tryParse(existingBibStr) ?? 0;
          if (existingBib > maxBib) {
            maxBib = existingBib;
          }
        }
      }
      bib = (maxBib + 1).toString(); 
    }

    final Participant newParticipant = participant.copyWith(id: id, bib: bib);
    await _databaseRef.child(id).set(ParticipantDto.toJson(newParticipant));
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
}
