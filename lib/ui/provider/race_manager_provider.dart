import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_tracker/data/repository/race_repository.dart';
import 'package:race_tracker/model/race.dart';
import 'package:race_tracker/ui/provider/async_value.dart';

class RaceManagerProvider extends ChangeNotifier {
  final RaceRepository _repository;
  AsyncValue<Race>? raceState;

  RaceManagerProvider(this._repository);

  bool get isLoading =>
      raceState != null && raceState!.state == AsyncValueState.loading;

  bool get hasData =>
      raceState != null && raceState!.state == AsyncValueState.success;

  Race? get race => raceState?.data;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  bool get isTracking => _stopwatch.isRunning;
  Duration get elapsed => _stopwatch.elapsed;

  // Fetch current race ID from the repository
  Future<String?> getCurrentRaceId() async {
    return await _repository.getCurrentRaceId();
  }

  // Start the Time and schedule UI updates.
  void start() async {
    try {
      raceState = AsyncValue.loading();
      notifyListeners();

      final race = await _repository.createAndStartRace();
      raceState = AsyncValue.success(race);
    } catch (e) {
      raceState = AsyncValue.error(e);
    }
    notifyListeners();

    _stopwatch.start();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (_) => notifyListeners(),
    );
  }

  // Pause and Save the Time and stop updates.
  void pauseAndSave() async {
    _stopwatch.stop();
    _timer?.cancel();

    if (raceState?.data == null) return;

    final currentRace = raceState!.data!;
    try {
      raceState = AsyncValue.loading();
      notifyListeners();

      await _repository.finishRace(currentRace.id);

      final updated = currentRace.copyWith(
        status: RaceStatus.finished,
        finishTime: DateTime.now(),
      );

      raceState = AsyncValue.success(updated);
    } catch (e) {
      raceState = AsyncValue.error(e);
    }

    notifyListeners();
  }

  // Reset the Time to zero.
  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
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
