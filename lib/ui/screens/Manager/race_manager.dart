import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/time_tracking_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/actions/rt_alert_dialog.dart';
import '../../widgets/actions/rt_button.dart';
import '../../widgets/navigation/rt_nav_bar.dart';
import '../../widgets/navigation/rt_top_bar.dart';

class RaceManager extends StatelessWidget {
  const RaceManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.backGroundColor,
      appBar: RTTopBar(title: 'Race Manager'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: RTSpacings.l,
              vertical: RTSpacings.xl,
            ),
            child: Text(
              "Ready to Start",
              style: RTTextStyles.heading.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: RTSpacings.xxl),
          // Timer display
          Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.only(bottom: RTSpacings.l),
            decoration: BoxDecoration(
              color: RTColors.backGroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  color: RTColors.black,
                  blurRadius: 15,
                ),
                BoxShadow(
                  offset: const Offset(-5, -5),
                  color: RTColors.white.withAlpha(200),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Consumer<RaceManagerProvider>(
              builder: (context, tracker, _) {
                final elapsed = tracker.elapsed;
                final minutes = elapsed.inMinutes.toString().padLeft(2, '0');
                final seconds = (elapsed.inSeconds % 60).toString().padLeft(
                  2,
                  '0',
                );
                final centis = ((elapsed.inMilliseconds / 10) % 100)
                    .floor()
                    .toString()
                    .padLeft(2, '0');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 40, color: RTColors.primary),
                    Text(
                      "$minutes:$seconds.$centis",
                      style: TextStyle(fontSize: 24, color: RTColors.black),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: RTSpacings.xl),
          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: RTSpacings.s),
            child: Consumer<RaceManagerProvider>(
              builder: (context, tracker, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Reset button with confirmation dialog
                    RTButton(
                      text: "Reset",
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => RTAlertDialog(
                                title: "Confirm Reset",
                                content:
                                    "Are you sure you want to reset the timer?",
                              ),
                        );
                        if (confirmed == true) {
                          tracker.reset();
                        }
                      },
                      type: ButtonType.secondary,
                      icon: Icons.refresh,
                    ),
                    const SizedBox(width: RTSpacings.xxl),
                    // Start/Save button
                    tracker.isTracking
                        ? RTButton(
                          text: "Save",
                          onPressed: tracker.toggle,
                          type: ButtonType.primary,
                          icon: Icons.save,
                        )
                        : RTButton(
                          text: "Start",
                          onPressed: tracker.toggle,
                          type: ButtonType.primary,
                          icon: Icons.play_arrow,
                        ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const RTNavBar(),
    );
  }
}
