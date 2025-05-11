import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/race_tracker_provider.dart';
import '../../theme/theme.dart';

class RtStartButtonListTile extends StatelessWidget {
  final String bib;

  const RtStartButtonListTile({super.key, required this.bib});

  @override
  Widget build(BuildContext context) {
    final raceTracker = context.watch<RaceTrackerProvider>();
    final isStarted = raceTracker.isStarted(bib);
    final elapsed = raceTracker.getElapsed(bib);

    // Format the elapsed time into a string
    String formatTime(Duration duration) {
      return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }

    // Handle the "Start" button tap
    void handleStart() {
      if (!isStarted) {
        raceTracker.startParticipant(bib);
      }
    }

    // Handle reset functionality
    void handleReset() {
      raceTracker.resetParticipant(bib);
    }

    return GestureDetector(
      onTap: isStarted ? null : handleStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: RTSpacings.s,
          horizontal: RTSpacings.m,
        ),
        decoration: BoxDecoration(
          color:
              elapsed == Duration.zero ? RTColors.primary : RTColors.secondary,
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (elapsed != Duration.zero) ...[
              Text(
                formatTime(elapsed),
                style: RTTextStyles.body.copyWith(color: RTColors.black),
              ),
              const SizedBox(width: 8),
              Icon(Icons.check, color: RTColors.success),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: handleReset,
                child: Icon(Icons.refresh, color: RTColors.primary),
              ),
            ] else ...[
              Text(
                "Start",
                style: RTTextStyles.body.copyWith(color: RTColors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
