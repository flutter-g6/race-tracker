class SegmentResult {
  final String bib;
  final String name;
  final Duration duration;

  SegmentResult({required this.bib, required this.name, required this.duration});
}

class OverallResult {
  final String bib;
  final String name;
  final Duration totalDuration;

  OverallResult({required this.bib, required this.name, required this.totalDuration});
}
