import 'package:race_tracker/model/race.dart';


abstract class RaceRepository {
  Future<void> startRace(String raceId);
  Future<void> finishRace(String raceId);
  Future<RaceStatus> getRaceStatus(String raceId);
  Stream<RaceStatus> watchRaceStatus(String raceId);
}
