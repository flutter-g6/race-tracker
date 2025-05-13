import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';
import '../../../widgets/actions/rt_button.dart';
import 'display_mode_selector.dart';

class ParticipantRangeSelector extends StatefulWidget {
  final ScrollController scrollController;
  final int participantsPerPage;

  const ParticipantRangeSelector({
    super.key,
    required this.scrollController,
    this.participantsPerPage = 50,
  });

  @override
  State<ParticipantRangeSelector> createState() =>
      _ParticipantRangeSelectorState();
}

class _ParticipantRangeSelectorState extends State<ParticipantRangeSelector> {
  int _selectedRangeIndex = 0; // Track the selected range index

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();
    final participantCount = provider.participants.length;
    final pageCount = (participantCount / widget.participantsPerPage).ceil();

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pageCount,
        separatorBuilder: (context, index) => const SizedBox(width: 3),
        itemBuilder: (context, index) {
          final start = index * widget.participantsPerPage + 1;
          final end = (index + 1) * widget.participantsPerPage;
          final actualEnd = end > participantCount ? participantCount : end;

          return RTButton(
            text: '$start-$actualEnd',
            type:
                _selectedRangeIndex == index
                    ? ButtonType.primary
                    : ButtonType.secondary,
            onPressed: () {
              _scrollToRange(context, index);
              setState(() {
                _selectedRangeIndex = index; // Update selected index
              });
            },
          );
        },
      ),
    );
  }

  void _scrollToRange(BuildContext context, int pageIndex) {
    final provider = context.read<ParticipantsTrackingProvider>();
    final firstItemIndex = pageIndex * widget.participantsPerPage;

    if (provider.displayMode == DisplayMode.grid) {
      final gridRow = (firstItemIndex / 5).floor();
      widget.scrollController.jumpTo(gridRow * 100);
    } else {
      widget.scrollController.jumpTo(firstItemIndex * 72);
    }
  }
}
