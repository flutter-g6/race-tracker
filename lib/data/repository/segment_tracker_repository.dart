import 'package:race_tracker/model/segment_record.dart';

abstract class SegmentTrackerRepository {
  Future<void> startSegment(String raceId, String bib, Segment segment);
  Future<void> finishSegment(String raceId, String bib, Segment  segment);
  //Stream<SegmentRecord?> watchSegment(String raceId, String bib, String segment);
}

