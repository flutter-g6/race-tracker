import 'dart:async';

import 'package:flutter/material.dart';

class TimeTrackingProvider extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  bool get isTracking => _stopwatch.isRunning;
  Duration get elapsed => _stopwatch.elapsed;

  // Start the Time and schedule UI updates.
  void start() {
    _stopwatch.start();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (_) => notifyListeners(),
    );
  }

  // Pause and Save the Time and stop updates.
  void pauseAndSave() {
    _stopwatch.stop();
    _timer?.cancel();
  }

  // Reset the Time to zero.
  void reset() {
    _stopwatch.reset();
    notifyListeners(); // Reset display
  }

  // Toggle between start and pauseAndSave.
  void toggle() {
    if (isTracking) {
      pauseAndSave();
    } else {
      start();
    }
    // No separate notify here; start() and pauseAndSave() already call it.
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
