import 'package:flutter/material.dart';

class ResultTable extends StatefulWidget {
  const ResultTable({super.key, this.title, required this.data});

  final String? title;
  final List<Map<String, String>> data;

  @override
  State<ResultTable> createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
  bool _isSortAscending = true;
  int _sortColumnIndex = 0;

  void sortData(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.data.sort((a, b) {
        final rankA =
            int.tryParse(a['rank']!.replaceAll(RegExp(r'\D'), '')) ?? 0;
        final rankB =
            int.tryParse(b['rank']!.replaceAll(RegExp(r'\D'), '')) ?? 0;
        return ascending ? rankA.compareTo(rankB) : rankB.compareTo(rankA);
      });
    } else if (columnIndex == 3) {
      widget.data.sort((a, b) {
        final timeA = a['runtime']!;
        final timeB = b['runtime']!;
        return ascending ? timeA.compareTo(timeB) : timeB.compareTo(timeA);
      });
    }
    setState(() {
      _sortColumnIndex = columnIndex;
      _isSortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          sortAscending: _isSortAscending,
          sortColumnIndex: _sortColumnIndex,
          columns: [
            DataColumn(
              label: const Text('Rank'),
              onSort: (index, ascending) => sortData(index, ascending),
            ),
            const DataColumn(label: Text('Bib')),
            const DataColumn(label: Text('Name')),
            DataColumn(
              label: const Text('Runtime'),
              onSort: (index, ascending) => sortData(index, ascending),
            ),
          ],
          rows:
              widget.data.map((row) {
                return DataRow(
                  cells: [
                    DataCell(Text(row['rank']!)),
                    DataCell(Text(row['bib']!)),
                    DataCell(Text(row['name']!)),
                    DataCell(Text(row['runtime']!)),
                  ],
                );
              }).toList(),
        ),
      ],
    );
  }
}
