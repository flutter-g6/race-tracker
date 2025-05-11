enum Segment { swim, run, cycle }

class SegmentRecord {
  final String bib;
  final String fullName;
  final Segment segment; 
  final DateTime startTime;
  final DateTime? finishTime;

  SegmentRecord({
    required this.fullName,
    required this.bib,
    required this.segment,
    required this.startTime,
    this.finishTime,
  });

}
