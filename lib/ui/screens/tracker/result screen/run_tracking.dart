import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/display/result_table.dart';

class RunTracking extends StatelessWidget {
  const RunTracking({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> data = [
      {'rank': '1st', 'bib': 'Bib191', 'name': 'Ronan', 'runtime': '00:24:52'},
      {'rank': '2nd', 'bib': 'Bib002', 'name': 'Heng', 'runtime': '00:25:32'},
      {'rank': '3rd', 'bib': 'Bib001', 'name': 'Sal', 'runtime': '00:45:02'},
      {'rank': '4th', 'bib': 'Bib003', 'name': 'Vath', 'runtime': '00:55:02'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Run Tracking'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(RTSpacings.m),
          child: ResultTable(title: 'Swimming', data: data),
        ),
      ),
    );
  }
}
