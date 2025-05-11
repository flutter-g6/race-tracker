import 'dart:async';

import 'package:flutter/material.dart';

class RaceTrackerProvider extends ChangeNotifier {
  final Map<String, DateTime> _participantStartTimes = {};
  Timer? _timer;

  ///
  /// Managing timer
  ///
  void _startNotifierLoop() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 32), (_) {
      notifyListeners();
    });
  }

  void startParticipant(String bib) {
    if (!_participantStartTimes.containsKey(bib)) {
      _participantStartTimes[bib] = DateTime.now();
      _startNotifierLoop();
      notifyListeners();
    }
  }

  Duration getElapsed(String bib) {
    final start = _participantStartTimes[bib];
    if (start == null) return Duration.zero;
    return DateTime.now().difference(start);
  }

  bool isStarted(String bib) => _participantStartTimes.containsKey(bib);

  void resetParticipant(String bib) {
    _participantStartTimes.remove(bib);
    notifyListeners();
  }
}
