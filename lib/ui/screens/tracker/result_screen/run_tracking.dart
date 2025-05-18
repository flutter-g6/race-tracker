import 'package:flutter/material.dart';

import 'layout/rt_result.dart';
import '../../../../model/segment_record.dart';

class RunTracking extends StatelessWidget {
  const RunTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const RTResult(segment: Segment.run, title: "Running");
  }
}
