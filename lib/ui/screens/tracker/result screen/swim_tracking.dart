import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/segment_record.dart';

import '../../../theme/theme.dart';
import '../../../widgets/display/result_table.dart';
import '../../../provider/result_provider.dart';

class SwimTracking extends StatelessWidget {
  const SwimTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      appBar: AppBar(title: const Text('Swimming Tracking'), centerTitle: true),
      body: Consumer<ResultProvider>(
        builder: (context, provider, _) {
          final results = provider.getSegmentResults(Segment.swim);

          if (results == null && !provider.isLoading) {
            Future.microtask(() {
              provider.fetchSegmentResults(Segment.swim);
            });
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(RTSpacings.m),
              child: provider.isLoading
                  ? const CircularProgressIndicator()
                  : results == null || results.isEmpty
                      ? const Text('No results found')
                      : ResultTable(
                          title: 'Swimming',
                          data: results
                              .asMap()
                              .entries
                              .map((entry) => {
                                    'rank': '${entry.key + 1}',
                                    'bib': entry.value.bib,
                                    'name': entry.value.name,
                                    'runtime': _formatDuration(entry.value.duration),
                                  })
                              .toList(),
                        ),
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
}
