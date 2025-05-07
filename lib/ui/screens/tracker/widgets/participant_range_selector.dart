import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';

import '../../../widgets/actions/rt_button.dart';

class ParticipantRangeSelector extends StatelessWidget {
  const ParticipantRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: provider.participantRanges.length,
        separatorBuilder: (context, index) => const SizedBox(width: 3),
        itemBuilder: (context, index) {
          final range = provider.participantRanges[index];
          return RTButton(
            text: '${range.range[0]}-${range.range[1]}',
            type:
                provider.selectedRange.index == range.index
                    ? ButtonType.primary
                    : ButtonType.secondary,
            onPressed: () => provider.setParticipantRange(range),
          );
        },
      ),
    );
  }
}
