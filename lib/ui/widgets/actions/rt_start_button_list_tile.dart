import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/participant.dart';

import '../../../model/segment_record.dart';
import '../../provider/race_tracker_provider.dart';
import '../../theme/theme.dart';

class RtStartButtonListTile extends StatelessWidget {
  final Participant participant;
  final Segment segment;

  const RtStartButtonListTile({
    super.key,
    required this.participant,
    required this.segment,
  });

  @override
  Widget build(BuildContext context) {
    final raceTracker = context.watch<RaceTrackerProvider>();
    final isStarted = raceTracker.isStarted(participant);
    final elapsed = raceTracker.getElapsed(participant);

    // Format the elapsed time into a string
    String formatTime(Duration duration) {
      return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }

    // Handle the "Start" button tap
    void handleStart() {
      if (!isStarted) {
        raceTracker.startParticipant(participant, segment);
      }
    }

    // Handle reset functionality
    void handleReset() {
      raceTracker.resetParticipant(participant, segment);
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
