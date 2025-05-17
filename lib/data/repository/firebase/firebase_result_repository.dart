import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/repository/firebase/firebase_segment_tracker_repository.dart';
import 'package:race_tracker/data/repository/result_repository.dart';
import 'package:race_tracker/model/result.dart';

class FirebaseResultRepository extends ResultRepository {
  final _db = FirebaseDatabase.instance.ref();
  final FirebaseSegmentTrackerRepository _segmentTrackerRepository =
      FirebaseSegmentTrackerRepository();

  @override
  Future<Map<String, dynamic>> getSegmentData(String segmentName) async {
    final raceId = await _segmentTrackerRepository.getActiveRaceId();
    final snapshot =
        await _db.child('race_segments/$raceId/$segmentName').get();

    if (!snapshot.exists) return {};

    final value = snapshot.value;

    if (value is List) {
      final result = <String, dynamic>{};
      for (var i = 0; i < value.length; i++) {
        final entry = value[i];
        if (entry != null) {
          result[i.toString()] = entry;
        }
      }
      return result;
    } else if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return {};
  }

  @override
  Future<List<Result>> getOverallData() {
    // TODO: implement getOverallData
    throw UnimplementedError();
  }
}
