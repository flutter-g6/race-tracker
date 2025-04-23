import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/repository/race_repository.dart';
import 'package:race_tracker/model/race.dart';


class FirebaseRaceRepository extends RaceRepository {
  final _raceRef = FirebaseDatabase.instance.ref().child('races');

  @override
  Future<void> startRace(String raceId) async {
    await _raceRef.child(raceId).update({
      'status': 'ongoing',
      'startTime': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> finishRace(String raceId) async {
    await _raceRef.child(raceId).update({
      'status': 'finished',
      'finishTime': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<RaceStatus> getRaceStatus(String raceId) async {
    final snapshot = await _raceRef.child(raceId).child('status').get();
    final statusString = snapshot.value as String;
    return RaceStatus.values.firstWhere((e) => e.name == statusString);
  }
}
