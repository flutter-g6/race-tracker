abstract class ResultRepository {
  Future<Map<String, dynamic>> getSegmentData(String segmentName);
  Future<List<Map<String, dynamic>>> getOverallData();
  Future<String> getSwimTimeFor(String bib);
  Future<String> getCycleTimeFor(String bib);
}
