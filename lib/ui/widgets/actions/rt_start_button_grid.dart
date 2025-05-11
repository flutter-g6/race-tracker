import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/race_manager_provider.dart';
import '../../theme/theme.dart';

class RtStartButtonGrid extends StatelessWidget {
  final String bib;

  const RtStartButtonGrid({super.key, required this.bib});

  @override
  Widget build(BuildContext context) {
    final raceTracker = context.watch<RaceManagerProvider>();
    final isTracking = raceTracker.isTracking;
    final elapsed = raceTracker.elapsed;

    // Format the elapsed time into a string
    String formatTime(Duration duration) {
      return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }

    // Handle the "Start" button tap
    void handleStart() {
      if (!isTracking && elapsed == Duration.zero) {
        raceTracker.start();
      }
    }

    return GestureDetector(
      onTap: isTracking ? null : handleStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: RTSpacings.s),
        decoration: BoxDecoration(
          color:
              elapsed == Duration.zero ? RTColors.primary : RTColors.secondary,
          borderRadius: BorderRadius.circular(RTSpacings.radiusSmall),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bib,
              style: RTTextStyles.subHeading.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    elapsed == Duration.zero ? RTColors.white : RTColors.black,
              ),
            ),
            const SizedBox(height: 4),
            if (elapsed != Duration.zero) ...[
              Text(
                formatTime(elapsed),
                style: RTTextStyles.text.copyWith(color: RTColors.black),
              ),
            ] else
              Text(
                "Start",
                style: RTTextStyles.body.copyWith(color: RTColors.white),
              ),
          ],
        ),
      ),
    );
  }
}
