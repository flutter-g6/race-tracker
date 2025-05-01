import 'package:race_tracker/model/participant.dart';

abstract class ParticipantRepository {
  Future<List<Participant>> getParticipants();
  Future<void> addParticipant(Participant participant);
  Future<void> updateParticipant(Participant participant);
  Future<void> deleteParticipant(String id);
  Future<void> restoreParticipant(Participant participant); 
}
