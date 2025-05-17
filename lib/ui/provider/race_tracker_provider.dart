import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_tracker/data/repository/firebase/firebase_race_repository.dart';
import 'package:race_tracker/data/repository/firebase/firebase_segment_tracker_repository.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/model/segment_record.dart';

class RaceTrackerProvider extends ChangeNotifier {
  StreamSubscription<bool>? _statusSubscription;
  String? _cachedRaceId;
  DateTime? _cacheStartTime;
  final Map<Participant, Set<Segment>> _finishedSegments = {};

  final FirebaseSegmentTrackerRepository? _segmentTrackerRepository;
  final FirebaseRaceRepository? _firebaseRaceRepository;

  RaceTrackerProvider(
    this._segmentTrackerRepository,
    this._firebaseRaceRepository,
  );

  // I am weirdly implement this
  // The goal here is for the provider to be able to listen the race status in real time.
  // But, I want to cache the rece id and start time
  // So always listening but cached? 
  Future<void> init() async {
    if (_statusSubscription != null) return;

    _statusSubscription = _firebaseRaceRepository!
        .watchIsRaceOngoing()
        .listen((isOngoing) async {
          if (isOngoing) {
            String? id = await _firebaseRaceRepository.getCurrentRaceId();
            _cachedRaceId = id;

            DateTime startTime = await _firebaseRaceRepository.getRaceStartTime(id ?? '');
            _cacheStartTime = startTime;
          } else {
            _cachedRaceId = null;
            _cacheStartTime = null;
          }

          notifyListeners();
        });
  }

  String? get currentRaceId => _cachedRaceId;
  DateTime? get startTime => _cacheStartTime;

  void finishParticipant(Participant participant, Segment segment) {
    _finishedSegments.putIfAbsent(participant, () => {}).add(segment);
    _segmentTrackerRepository?.finishSegment(participant.bib, segment);
    notifyListeners();
  }

  Duration getElapsed(Participant participant) {
    if (_cacheStartTime == null) return Duration.zero;
    return DateTime.now().difference(_cacheStartTime!);
  }

  bool isStarted(Participant participant) => _cacheStartTime != null;

  void resetParticipant(Participant participant, Segment segment) {
    _finishedSegments.remove(participant);
    notifyListeners();
  }

  bool isFinished(Participant participant, Segment segment) {
    return _finishedSegments[participant]?.contains(segment) ?? false;
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}
