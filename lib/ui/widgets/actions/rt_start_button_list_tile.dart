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
    final isFinished = raceTracker.isFinished(participant, segment);
    final canFinish = raceTracker.canFinishSegment(participant, segment);
    final elapsed = raceTracker.getElapsed(participant);

    // Handle the "Finish" button tap
    void handleFinish() {
      if (isStarted && !isFinished) {
        raceTracker.finishParticipant(participant, segment);
      }
    }

    // Handle reset functionality
    void handleReset() {
      raceTracker.resetParticipant(participant, segment);
    }

    Color getButtonColor(Duration elapsed) {
      if (isFinished) return RTColors.secondary;
      if (isStarted && !isFinished && canFinish) return RTColors.primary;
      return RTColors.disabled;
    }

    VoidCallback? getOnTap() {
      // If finished, allow reset
      if (isFinished) return handleReset;

      // Is Started is checking if the manager has started the race
      // Is not finished is self explanatory
      // Can finish because the last segment is finished
      if (isStarted && !isFinished && canFinish) return handleFinish;

      // Otherwise, disable
      return null;
    }

    return GestureDetector(
      onTap: getOnTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: RTSpacings.s,
          horizontal: RTSpacings.m,
        ),
        decoration: BoxDecoration(
          color: getButtonColor(elapsed),
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFinished ? "Reset" : "Finish",
              style: RTTextStyles.body.copyWith(
                color:
                    (isFinished || (isStarted && !isFinished && canFinish))
                        ? RTColors.white
                        : RTColors.disabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
