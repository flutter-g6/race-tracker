import 'package:flutter/material.dart';

import 'layout/rt_result.dart';
import '../../../../model/segment_record.dart';

class CycleTracking extends StatelessWidget {
  const CycleTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return RTResult(segment: Segment.cycle, title: "Cycling");
  }
}
