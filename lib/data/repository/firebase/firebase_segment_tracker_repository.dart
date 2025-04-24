import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/repository/firebase/firebase_race_repository.dart';
import 'package:race_tracker/data/repository/segment_tracker_repository.dart';
import 'package:race_tracker/model/race.dart';

class FirebaseSegmentTrackerRepository extends SegmentTrackerRepository {
  final FirebaseRaceRepository _raceRepository = FirebaseRaceRepository();
  final _db = FirebaseDatabase.instance.ref();
  
  Future<bool> _isRaceOngoing(String raceId) async {
    final status = await _raceRepository.getRaceStatus(raceId);
    if (status != RaceStatus.ongoing) {
      return false;
    }
    return true;
  }
}
