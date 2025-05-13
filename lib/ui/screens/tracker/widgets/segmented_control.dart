// lib/widgets/segmented_control.dart
import 'package:flutter/material.dart';
import '../../../../model/segment_record.dart';
import '../../../theme/theme.dart';

class RTSegmentedControl extends StatefulWidget {
  final Segment selectedSport;
  final ValueChanged<Segment> onSelectionChanged;

  const RTSegmentedControl({
    super.key,
    required this.selectedSport,
    required this.onSelectionChanged,
  });

  @override
  State<RTSegmentedControl> createState() => _RTSegmentedControlState();
}

class _RTSegmentedControlState extends State<RTSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<Segment>(
        segments:
            Segment.values.map((sport) {
              return ButtonSegment<Segment>(
                value: sport,
                icon: _sportIcon(sport),
                label: _sportLabel(sport),
              );
            }).toList(),
        selected: {widget.selectedSport},
        onSelectionChanged: (Set<Segment> newSelection) {
          widget.onSelectionChanged(newSelection.first);
        },
        style: _segmentedButtonStyle(),
        showSelectedIcon: false,
      ),
    );
  }

  Icon _sportIcon(Segment sport) {
    switch (sport) {
      case Segment.run:
        return const Icon(Icons.directions_run, size: RTSizes.smallIcon);
      case Segment.swim:
        return const Icon(Icons.pool, size: RTSizes.smallIcon);
      case Segment.cycle:
        return const Icon(Icons.directions_bike, size: RTSizes.smallIcon);
    }
  }

  Text _sportLabel(Segment sport) {
    return Text(
      sport.toString().split('.').last[0].toUpperCase() +
          sport.toString().split('.').last.substring(1),
      style: RTTextStyles.smallButton
    );
  }

  ButtonStyle _segmentedButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return RTColors.primary;
        }
        return RTColors.backgroundAccent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return RTColors.white;
        }
        return RTColors.black;
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
      ),
      side: WidgetStateProperty.all<BorderSide>(BorderSide.none),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 5, horizontal: RTSpacings.s),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(80, 60)),
      iconSize: WidgetStateProperty.all<double>(RTSizes.mediumIcon),
    );
  }
}
