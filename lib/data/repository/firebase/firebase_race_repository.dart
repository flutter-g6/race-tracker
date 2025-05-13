import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/dto/race_dto.dart';
import 'package:race_tracker/data/repository/race_repository.dart';
import 'package:race_tracker/model/race.dart';


class FirebaseRaceRepository extends RaceRepository {
  final _raceRef = FirebaseDatabase.instance.ref().child('races');
  final _currentRaceIdRef = FirebaseDatabase.instance.ref('current_race_id');

  @override
  Future<Race> createAndStartRace() async {
    final newRef = _raceRef.push();
    final raceId = newRef.key!;

    final now = DateTime.now();

    final race = Race(
      id: raceId,
      status: RaceStatus.ongoing,
      startTime: now,
      finishTime: null,
    );

    await newRef.set(RaceDto.toJson(race));

    // Save current active race ID
    await FirebaseDatabase.instance.ref('current_race_id').set(raceId);

    return race;
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

  @override
  Stream<RaceStatus> watchRaceStatus(String raceId) {
    return _raceRef.child(raceId).child('status').onValue.map((event) {
      final statusString = event.snapshot.value as String;
      return RaceStatus.values.firstWhere((e) => e.name == statusString);
    });
  }

   @override
  Future<String?> getCurrentRaceId() async {
    final snapshot = await _currentRaceIdRef.get();
    return snapshot.value as String?;
  }

}
