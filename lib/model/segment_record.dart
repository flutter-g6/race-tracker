enum Segment { swim, run, cycle }

class SegmentRecord {
  final int bib;
  final Segment segment; 
  final DateTime startTime;
  final DateTime? finishTime;

  SegmentRecord({
    required this.bib,
    required this.segment,
    required this.startTime,
    this.finishTime,
  });

}
