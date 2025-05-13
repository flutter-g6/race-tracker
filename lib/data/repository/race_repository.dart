import 'package:race_tracker/model/race.dart';


abstract class RaceRepository {
  Future<Race> createAndStartRace();
  Future<void> finishRace(String raceId);
  Future<RaceStatus> getRaceStatus(String raceId);
  Stream<RaceStatus> watchRaceStatus(String raceId);
  Future<String?> getCurrentRaceId();
}
