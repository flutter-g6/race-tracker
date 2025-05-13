import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/repository/firebase/firebase_segment_tracker_repository.dart';
import 'package:race_tracker/data/repository/result_repository.dart';
import 'package:race_tracker/model/result.dart';
import 'package:race_tracker/model/segment_record.dart';

class FirebaseResultRepository extends ResultRepository {
  final _db = FirebaseDatabase.instance.ref();
  final FirebaseSegmentTrackerRepository _segmentTrackerRepository = FirebaseSegmentTrackerRepository();

  Future<Map<String, dynamic>> _getSegmentData(String segmentName) async {
    final raceId = await _segmentTrackerRepository.getActiveRaceId();
    final snapshot = await _db.child('race_segments/$raceId/$segmentName').get();
    
    if (!snapshot.exists) return {};

    final value = snapshot.value;

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    } else if (value is List) {
      // Convert List to Map by using index or some ID if available
      final result = <String, dynamic>{};
      for (int i = 0; i < value.length; i++) {
        final item = value[i];
        if (item != null) {
          result[i.toString()] = item; // Or use item['bib'] if available
        }
      }
      return result;
    } else {
      print('⚠️ Unexpected data format: ${value.runtimeType}');
      return {};
    }
  }

  SegmentResult _parseSegmentResult(String bib, Map<String, dynamic> data) {
    final start = DateTime.parse(data['startTime']);
    final finish = DateTime.parse(data['finishTime']);
    final duration = finish.difference(start);
    return SegmentResult(
      bib: bib,
      name: data['fullName'] ?? '',
      duration: duration,
    );
  }

  @override
  Future<List<SegmentResult>> getSegmentResults(Segment segment) async {
    final data = await _getSegmentData(segment.name);
    final results = data.entries
        .map((entry) => _parseSegmentResult(entry.key, Map<String, dynamic>.from(entry.value)))
        .toList();
    results.sort((a, b) => a.duration.compareTo(b.duration));
    return results;
  }

  @override
  Future<List<OverallResult>> getOverallResults() async {
    final participantTimes = <String, Duration>{};
    final participantNames = <String, String>{};

    for (final segment in Segment.values) {
      final data = await _getSegmentData(segment.name);
      data.forEach((bib, value) {
        final result = _parseSegmentResult(bib, Map<String, dynamic>.from(value));
        participantTimes[bib] = (participantTimes[bib] ?? Duration.zero) + result.duration;
        participantNames[bib] = result.name;
      });
    }

    final results = participantTimes.entries.map((entry) {
      return OverallResult(
        bib: entry.key,
        name: participantNames[entry.key] ?? '',
        totalDuration: entry.value,
      );
    }).toList();

    results.sort((a, b) => a.totalDuration.compareTo(b.totalDuration));
    return results;
  }
}
