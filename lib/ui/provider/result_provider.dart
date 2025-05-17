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

    final futureResults =
        data.entries
            .map(
              (entry) => _parseSegmentResult(
                entry.key,
                Map<String, dynamic>.from(entry.value),
                segment,
              ),
            )
            .toList();

    final results = await Future.wait(futureResults);

    results.sort((a, b) => a.duration.compareTo(b.duration));

    return results;
  }

  Future<Result> _parseSegmentResult(
    String bib,
    Map<String, dynamic> data,
    Segment segment,
  ) async {
    DateTime startTime;
    DateTime finishTime = DateTime.parse(data['finishTime']);
    switch (segment) {
      case Segment.swim:
        startTime = DateTime.parse(data['startTime']);
        break;
      case Segment.cycle:
        startTime = DateTime.parse(await resultRepository.getSwimTimeFor(bib));
        break;
      default:
        startTime = DateTime.parse(await resultRepository.getCycleTimeFor(bib));
    }

    final duration = finishTime.difference(startTime);
    return Result(bib: bib, name: data['fullName'], duration: duration);
  }

  Future<List<Result>>? getOverallResults() async {
    final data = await resultRepository.getSegmentData(Segment.run.name);

    final raceId = await raceRepository.getCurrentRaceId();
    final startTime = await raceRepository.getRaceStartTime(raceId!);

    data.updateAll(
      (key, value) => {...value, 'startTime': startTime.toIso8601String()},
    );

    final futureResults =
        data.entries
            .map(
              (entry) => _parseOverallResult(
                entry.key,
                Map<String, dynamic>.from(entry.value),
                Segment.run,
              ),
            )
            .toList();

    final results = await Future.wait(futureResults);

    results.sort((a, b) => a.duration.compareTo(b.duration));

    return results;
  }

  Future<Result> _parseOverallResult(
    String bib,
    Map<String, dynamic> data,
    Segment segment,
  ) async {
    DateTime startTime = DateTime.parse(data['startTime']);
    DateTime finishTime = DateTime.parse(data['finishTime']);

    final duration = finishTime.difference(startTime);
    return Result(bib: bib, name: data['fullName'], duration: duration);
  }
}
