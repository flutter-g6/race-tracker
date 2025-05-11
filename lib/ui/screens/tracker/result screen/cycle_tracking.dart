import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/segment_record.dart';
import 'package:race_tracker/ui/provider/result_provider.dart';
import 'package:race_tracker/ui/widgets/display/result_table.dart';

class CycleTracking extends StatelessWidget {
  const CycleTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cycle Tracking'), centerTitle: true),
      body: Consumer<ResultProvider>(
        builder: (context, provider, _) {
          final results = provider.getSegmentResults(Segment.cycle);

          // Trigger fetch if not loaded
          if (results == null && !provider.isLoading) {
            Future.microtask(() {
              provider.fetchSegmentResults(Segment.cycle);
            });
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: provider.isLoading
                  ? const CircularProgressIndicator()
                  : results == null || results.isEmpty
                      ? const Text('No results found')
                      : ResultTable(
                          title: 'Cycling',
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
