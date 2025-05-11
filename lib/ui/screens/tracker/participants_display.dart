import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';
import 'package:race_tracker/ui/widgets/actions/rt_start_button_list_tile.dart';

import '../../widgets/actions/rt_start_button_grid.dart';
import '../../theme/theme.dart';
import '../../widgets/display/rt_divider.dart';

class ParticipantDisplay extends StatelessWidget {
  const ParticipantDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();

    return switch (provider.displayMode) {
      DisplayMode.list => Padding(
        padding: EdgeInsets.symmetric(vertical: RTSpacings.s),
        child: ListView.separated(
          itemCount:
              provider.selectedRange.range[1] -
              provider.selectedRange.range[0] +
              1,
          separatorBuilder: (context, index) => const RTDivider(),
          itemBuilder: (context, index) {
            final participantNumber = provider.selectedRange.range[0] + index;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: RTSpacings.m,
                vertical: RTSpacings.s,
              ),
              child: Row(
                children: [
                  Text(
                    participantNumber.toString(),
                    style: RTTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: RTColors.black,
                    ),
                  ),
                  const SizedBox(width: RTSpacings.m),
                  Expanded(
                    child: Text(
                      'Participant Name',
                      style: RTTextStyles.body.copyWith(color: RTColors.black),
                    ),
                  ),
                  RtStartButtonListTile(bib: participantNumber.toString()),
                ],
              ),
            );
          },
        ),
      ),
      DisplayMode.grid => Padding(
        padding: const EdgeInsets.symmetric(vertical: RTSpacings.s),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: RTSpacings.m,
            mainAxisSpacing: RTSpacings.m,
          ),
          itemCount:
              provider.selectedRange.range[1] -
              provider.selectedRange.range[0] +
              1,
          itemBuilder: (context, index) {
            final participantNumber = provider.selectedRange.range[0] + index;
            return Center(
              child: RtStartButtonGrid(bib: participantNumber.toString()),
            );
          },
        ),
      ),
      DisplayMode.massStart => Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.play_arrow, color: RTColors.white),
          label: Text(
            'Start All Participants',
            style: RTTextStyles.button.copyWith(color: RTColors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: RTColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: RTSpacings.l,
              vertical: RTSpacings.m,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(RTSpacings.radius),
            ),
          ),
          onPressed: () {
            final range = provider.selectedRange;
            print('Starting participants ${range.range[0]}-${range.range[1]}');
          },
        ),
      ),
    };
  }
}
