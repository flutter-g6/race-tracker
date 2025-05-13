import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/participant.dart';
import '../../../model/segment_record.dart';
import '../../provider/race_tracker_provider.dart';
import '../../provider/race_manager_provider.dart';
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
    final raceManager = context.watch<RaceManagerProvider>();
    final isStarted = raceTracker.isStarted(participant);
    final elapsed = raceTracker.getElapsed(participant);
    final isFinished = raceTracker.isFinished(participant, segment);

    // Format the elapsed time into a string
    String formatTime(Duration duration) {
      return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }

    // Handle the "Start" button tap
    void handleStart() async {
      try {
        // Get the current race ID from Firebase
        final currentRaceId = await raceManager.getCurrentRaceId();

        // If no race ID exists, show an error message
        if (currentRaceId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No active race. Manager must start a race first.'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        // Proceed with starting the participant tracking
        if (!isStarted) {
          raceTracker.startParticipant(participant, segment);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Participant tracking started!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        // Handle any errors during the check
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking race status: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

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
      if (isStartButton) {
        return elapsed == Duration.zero ? RTColors.primary : RTColors.secondary;
      } else {
        if (isFinished) return RTColors.secondary;
        return elapsed == Duration.zero ? RTColors.disabled : RTColors.primary;
      }
    }

    VoidCallback? getOnTap(bool isStarted, bool isFinished) {
      if (isStartButton) {
        // Start screen: only allow tap if not already started
        return isStarted ? null : handleStart;
      } else {
        // Finish screen:
        // If never started and not finished — disable
        if (!isStarted && !isFinished) return null;

        // If started and not finished — allow finish
        if (isStarted && !isFinished) return handleFinish;

        // If finished, allow reset
        if (isFinished) return handleReset;
      }
      return null;
    }

    return GestureDetector(
      onTap: getOnTap(isStarted, isFinished),
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
                isFinished ? "Reset" : "Finish",
                style: RTTextStyles.body.copyWith(
                  color:
                      (elapsed == Duration.zero && !isFinished)
                          ? RTColors.disabled
                          : RTColors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
