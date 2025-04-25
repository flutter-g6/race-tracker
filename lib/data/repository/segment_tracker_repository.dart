import 'package:race_tracker/model/segment_record.dart';

abstract class SegmentTrackerRepository {
  Future<void> startSegment(String raceId, int bib, Segment segment);
  Future<void> finishSegment(String raceId, int bib, Segment  segment);
  Future<void> startAllParticipantsForSegment (String raceId, Segment segment);
  Future<void> unTrackStart(String raceId, int bib, Segment segment);
  Future<void> unTrackFinish(String raceId, int bib, Segment segment);
  //Stream<SegmentRecord?> watchSegment(String raceId, String bib, String segment);
}

