import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker/model/segment_record.dart';

import '../../../../model/result.dart';
import '../../../widgets/display/result_table.dart';
import '../../../provider/result_provider.dart'; // Adjust the path

class RunTracking extends StatelessWidget {
  const RunTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Run Tracking'), centerTitle: true),
      body: Consumer<ResultProvider>(
        builder: (context, provider, _) {
          return FutureBuilder<List<Result>>(
            future: provider.getSegmentResults(Segment.run),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final results = snapshot.data;

              if (results == null || results.isEmpty) {
                return const Center(child: Text('No results found'));
              }

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ResultTable(
                    title: 'Cycling',
                    data:
                        results
                            .asMap()
                            .entries
                            .map(
                              (entry) => {
                                'rank': '${entry.key + 1}',
                                'bib': entry.value.bib,
                                'name': entry.value.name,
                                'runtime': _formatDuration(
                                  entry.value.duration,
                                ),
                              },
                            )
                            .toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
}
