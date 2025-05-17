import 'package:flutter/material.dart';
import 'package:race_tracker/data/repository/result_repository.dart';
import 'package:race_tracker/model/result.dart';
import 'package:race_tracker/model/segment_record.dart';

class ResultProvider extends ChangeNotifier {
  final ResultRepository resultRepository;

  ResultProvider(this.resultRepository);

  final Map<Segment, List<SegmentResult>> _segmentResults = {};
  List<OverallResult>? _overallResults;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<OverallResult>? get overallResults => _overallResults;

  List<SegmentResult>? getSegmentResults(Segment segment) =>
      _segmentResults[segment];

  Future<void> fetchSegmentResults(Segment segment) async {
    _isLoading = true;
    notifyListeners();

    final results = await resultRepository.getSegmentResults(segment);
    _segmentResults[segment] = results;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchOverallResults() async {
    _isLoading = true;
    notifyListeners();

    _overallResults = await resultRepository.getOverallResults();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      fetchSegmentResults(Segment.swim),
      fetchSegmentResults(Segment.run),
      fetchSegmentResults(Segment.cycle),
      fetchOverallResults(),
    ]);

    _isLoading = false;
    notifyListeners();
  }
}
