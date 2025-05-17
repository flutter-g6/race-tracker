import 'package:race_tracker/model/race.dart';


abstract class RaceRepository {
  Future<Race> createAndStartRace();
  Future<void> finishRace(String raceId);
  Future<DateTime> getRaceStartTime(String raceId);
  Stream<bool> watchIsRaceOngoing();
  Future<String?> getCurrentRaceId();
}
