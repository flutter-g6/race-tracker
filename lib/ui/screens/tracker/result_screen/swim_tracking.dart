import 'package:flutter/material.dart';

import 'layout/rt_result.dart';
import '../../../../model/segment_record.dart';

class SwimTracking extends StatelessWidget {
  const SwimTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return RTResult(segment: Segment.swim, title: "Swimming");
  }
}
