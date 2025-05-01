import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/time_tracking_provider.dart';
import '../../theme/theme.dart';

class RTParticipantButton extends StatelessWidget {
  final String bib;

  const RTParticipantButton({super.key, required this.bib});

  @override
  Widget build(BuildContext context) {
    final raceTracker = context.watch<RaceManagerProvider>();
    final isTracking = raceTracker.isTracking;
    final elapsed = raceTracker.elapsed;

    String formatTime(Duration duration) {
      return "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }

    void handleTap() {
      if (!isTracking && elapsed == Duration.zero) {
        raceTracker.start();
      } else if (isTracking) {
        raceTracker.pauseAndSave();
      }
    }

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isTracking || elapsed != Duration.zero
                  ? RTColors.warning
                  : RTColors.primary,
          borderRadius: BorderRadius.circular(RTSpacings.radius),
          border: Border.all(
            color:
                elapsed != Duration.zero && !isTracking
                    ? RTColors.success
                    : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              bib,
              style: RTTextStyles.heading.copyWith(
                color:
                    elapsed != Duration.zero && !isTracking
                        ? RTColors.black
                        : RTColors.white,
              ),
            ),
            const SizedBox(height: RTSpacings.s),
            if (elapsed != Duration.zero && !isTracking)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: RTColors.success),
                  const SizedBox(width: 4),
                  Text(
                    formatTime(elapsed),
                    style: RTTextStyles.body.copyWith(color: RTColors.black),
                  ),
                ],
              )
            else
              Text(
                isTracking ? "Finish" : "Start",
                style: RTTextStyles.body.copyWith(color: RTColors.white),
              ),
          ],
        ),
      ),
    );
  }
}
