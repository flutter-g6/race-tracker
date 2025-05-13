import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/participant.dart';

import '../../../model/segment_record.dart';
import '../../provider/race_tracker_provider.dart';
import '../../theme/theme.dart';

class RtStartButtonListTile extends StatelessWidget {
  final Participant participant;
  final Segment segment;
  final bool isStartButton;

  const RtStartButtonListTile({
    super.key,
    required this.participant,
    required this.segment,
    required this.isStartButton,
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
      onTap: isStartButton ? (isStarted ? null : handleStart) : handleReset,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: RTSpacings.s,
          horizontal: RTSpacings.m,
        ),
        decoration: BoxDecoration(
          color: _getButtonColor(elapsed),
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isStartButton) ...[
              if (elapsed != Duration.zero) ...[
                Text(
                  formatTime(elapsed),
                  style: RTTextStyles.body.copyWith(color: RTColors.black),
                ),
                const SizedBox(width: 8),
                Icon(Icons.check, color: RTColors.success),
              ] else ...[
                Text(
                  "Start",
                  style: RTTextStyles.body.copyWith(color: RTColors.white),
                ),
              ],
            ] else ...[
              Text(
                "Finish",
                style: RTTextStyles.body.copyWith(color: RTColors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(Duration elapsed) {
    if (isStartButton) {
      return elapsed == Duration.zero ? RTColors.primary : RTColors.secondary;
    } else {
      return elapsed == Duration.zero ? RTColors.disabled : RTColors.primary;
    }
  }
}
