import 'package:flutter/material.dart';
import 'package:race_tracker/data/repository/result_repository.dart';
import 'package:race_tracker/model/result.dart';
import 'package:race_tracker/model/segment_record.dart';

import '../../data/repository/race_repository.dart';

class ResultProvider extends ChangeNotifier {
  final ResultRepository resultRepository;
  final RaceRepository raceRepository;

  ResultProvider(this.resultRepository, this.raceRepository);

  Future<List<Result>>? getSegmentResults(Segment segment) async {
    final data = await resultRepository.getSegmentData(segment.name);

    final raceId = await raceRepository.getCurrentRaceId();
    final startTime = await raceRepository.getRaceStartTime(raceId!);

    data.updateAll(
      (key, value) => {...value, 'startTime': startTime.toIso8601String()},
    );

    final results =
        data.entries
            .map(
              (entry) => _parseSegmentResult(
                entry.key,
                Map<String, dynamic>.from(entry.value),
              ),
            )
            .toList();
    results.sort((a, b) => a.duration.compareTo(b.duration));

    return results;
  }

  Result _parseSegmentResult(String bib, Map<String, dynamic> data) {
    final start = DateTime.parse(data['startTime']);
    final finish = DateTime.parse(data['finishTime']);
    final duration = finish.difference(start);
    return Result(bib: bib, name: data['fullName'], duration: duration);
  }

  Future<List<Result>?> getOverallResults() async {
    final data = await resultRepository.getOverallData();
    return null;
  }
}
