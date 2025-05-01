import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/data/repository/participant_repository.dart';

class FakeParticipantRepository extends ParticipantRepository {
  final List<Participant> _participants = [];

  @override
  Future<void> restoreParticipant(Participant participant) async {
    await Future.delayed(Duration(milliseconds: 500));
    _participants.add(participant);
  }
  
  @override
  Future<List<Participant>> getParticipants() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _participants;
  }

  @override
  Future<void> addParticipant(Participant participant) async {
    await Future.delayed(Duration(milliseconds: 500));
    _participants.add(participant);
  }

  @override
  Future<void> updateParticipant(Participant participant) async {
    await Future.delayed(Duration(milliseconds: 500));
    final index = _participants.indexWhere((p) => p.id == participant.id);
    if (index != -1) _participants[index] = participant;
  }

  @override
  Future<void> deleteParticipant(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    _participants.removeWhere((p) => p.id == id);
  }
}
