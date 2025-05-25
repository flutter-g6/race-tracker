import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/dto/race_dto.dart';
import 'package:race_tracker/data/repository/race_repository.dart';
import 'package:race_tracker/model/race.dart';

class FirebaseRaceRepository extends RaceRepository {
  final _raceRef = FirebaseDatabase.instance.ref().child('races');

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
  Future<DateTime> getRaceStartTime(String raceId) async {
    final snapshot = await _raceRef.child(raceId).child('startTime').get();
    return DateTime.parse(snapshot.value as String);
  }

  @override
  Stream<bool> watchIsRaceOngoing() {
    final currentRaceIdRef = FirebaseDatabase.instance.ref('current_race_id');

    return currentRaceIdRef.onValue.asyncExpand((event) {
      final raceId = event.snapshot.value as String?;
      if (raceId == null) return Stream.value(false);

      return _raceRef.child(raceId).child('status').onValue.map((statusEvent) {
        final status = statusEvent.snapshot.value as String?;
        return status == RaceStatus.ongoing.name;
      });
    });
  }

  @override
  Future<String?> getCurrentRaceId() async {
    final snapshot =
        await FirebaseDatabase.instance.ref('current_race_id').get();
    return snapshot.value as String?;
  }
}
