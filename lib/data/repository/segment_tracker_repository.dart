import 'package:race_tracker/model/segment_record.dart';

abstract class SegmentTrackerRepository {
  Future<void> finishSegment( String bib, Segment  segment);
  Future<void> startAllParticipantsForSegment ( Segment segment);
  Future<void> unTrackFinish(String bib, Segment segment);
  Future<List<SegmentRecord>> getSegmentTrackingStatus(Segment segment);
  //Stream<SegmentRecord?> watchSegment(String raceId, String bib, String segment);
}

