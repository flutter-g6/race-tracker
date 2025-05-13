import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_tracker/data/repository/firebase/firebase_segment_tracker_repository.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/model/segment_record.dart';

class RaceTrackerProvider extends ChangeNotifier {
  final Map<Participant, DateTime> _participantStartTimes = {};
  final Map<Participant, Set<Segment>> _finishedSegments = {};

  Timer? _timer;
  final FirebaseSegmentTrackerRepository? _segmentTrackerRepository;

  RaceTrackerProvider(this._segmentTrackerRepository);

  ///
  /// Managing timer visually
  ///
  void _startNotifierLoop() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 32), (_) {
      notifyListeners();
    });
  }

  void startParticipant(Participant participant, Segment segment) {
    if (!_participantStartTimes.containsKey(participant)) {
      _participantStartTimes[participant] = DateTime.now();
      _segmentTrackerRepository?.startSegment(
        "${participant.firstName} ${participant.firstName}",
        participant.bib,
        segment,
      );
      _startNotifierLoop();
      notifyListeners();
    }
  }

  void finishParticipant(Participant participant, Segment segment) {
    if (_participantStartTimes.containsKey(participant)) {
      _finishedSegments.putIfAbsent(participant, () => {}).add(segment);
      _segmentTrackerRepository?.finishSegment(
        "${participant.firstName} ${participant.firstName}",
        segment,
      );
      notifyListeners();
    }
  }

  Duration getElapsed(Participant participant) {
    final start = _participantStartTimes[participant];
    if (start == null) return Duration.zero;
    return DateTime.now().difference(start);
  }

  bool isStarted(Participant participant) =>
      _participantStartTimes.containsKey(participant);

  void resetParticipant(Participant participant, Segment segment) {
    _finishedSegments.remove(participant);
    notifyListeners();
  }

  bool isFinished(Participant participant, Segment segment) {
    return _finishedSegments[participant]?.contains(segment) ?? false;
  }
}
