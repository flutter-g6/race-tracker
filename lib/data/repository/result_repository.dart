import 'package:race_tracker/model/result.dart';
import 'package:race_tracker/model/segment_record.dart';

abstract class ResultRepository {
  Future<List<SegmentResult>> getSegmentResults( Segment segment);
  Future<List<OverallResult>> getOverallResults();
}
