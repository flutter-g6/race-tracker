import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/result.dart';
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
          return FutureBuilder<List<Result>?>(
            future: provider.getOverallResults(),
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
                    title: 'Leader Board',
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
