import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../widgets/display/result_table.dart';
import '../../../provider/result_provider.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leader Board'), centerTitle: true),
      body: Consumer<ResultProvider>(
        builder: (context, provider, _) {
          final results = provider.overallResults;

          // Trigger fetch if not already done
          if (results == null && !provider.isLoading) {
            Future.microtask(() {
              provider.fetchOverallResults();
            });
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(RTSpacings.m),
              child:
                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : results == null || results.isEmpty
                      ? const Text('No results found')
                      : ResultTable(
                        title: 'Overall Leaderboard',
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
                                      entry.value.totalDuration,
                                    ),
                                  },
                                )
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
