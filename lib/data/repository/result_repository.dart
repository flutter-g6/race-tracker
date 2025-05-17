import 'package:race_tracker/model/result.dart';

abstract class ResultRepository {
  Future<Map<String, dynamic>> getSegmentData(String segmentName);
  Future<List<Result>> getOverallData();
  Future<String> getSwimTimeFor(String bib);
  Future<String> getCycleTimeFor(String bib);
}
