import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/ui/provider/participants_tracking_provider.dart';
import 'package:race_tracker/ui/widgets/actions/rt_start_button_list_tile.dart';

import '../../../../model/segment_record.dart';
import '../../../widgets/actions/rt_start_button_grid.dart';
import '../../../theme/theme.dart';
import '../../../widgets/display/rt_divider.dart';
import 'display_mode_selector.dart';
import 'participant_range_selector.dart';

class ParticipantDisplay extends StatefulWidget {
  const ParticipantDisplay({super.key, required this.segment});

  final Segment segment;

  @override
  State<ParticipantDisplay> createState() => _ParticipantDisplayState();
}

class _ParticipantDisplayState extends State<ParticipantDisplay> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParticipantsTrackingProvider>();

    // Add this to trigger the data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!provider.isLoading && provider.participants.isEmpty) {
        provider.fetchParticipants();
      }
    });

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(child: _buildContent(provider)),
        const SizedBox(height: RTSpacings.m),
        ParticipantRangeSelector(scrollController: _scrollController),
      ],
    );
  }

  Widget _buildContent(ParticipantsTrackingProvider provider) {
    if (provider.participants.isEmpty) {
      return Center(
        child: Text(
          'No participants to display.',
          style: RTTextStyles.body.copyWith(color: RTColors.black),
        ),
      );
    }

    return switch (provider.displayMode) {
      DisplayMode.list => _buildListView(provider),
      DisplayMode.grid => _buildGridView(provider),
    };
  }

  Widget _buildListView(ParticipantsTrackingProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: RTSpacings.s),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: provider.participants.length,
        separatorBuilder: (context, index) => const RTDivider(),
        itemBuilder: (context, index) {
          final participant = provider.participants[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: RTSpacings.m,
              vertical: RTSpacings.s,
            ),
            child: Row(
              children: [
                Text(
                  participant.bib,
                  style: RTTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: RTColors.black,
                  ),
                ),
                const SizedBox(width: RTSpacings.m),
                Expanded(
                  child: Text(
                    participant.firstName,
                    style: RTTextStyles.body.copyWith(color: RTColors.black),
                  ),
                ),
                RtStartButtonListTile(
                  participant: participant,
                  segment: widget.segment,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView(ParticipantsTrackingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: RTSpacings.s),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: RTSpacings.m,
          mainAxisSpacing: RTSpacings.m,
        ),
        itemCount: provider.participants.length,
        itemBuilder: (context, index) {
          final participant = provider.participants[index];
          return Center(child: RtStartButtonGrid(bib: participant.bib));
        },
      ),
    );
  }
}
