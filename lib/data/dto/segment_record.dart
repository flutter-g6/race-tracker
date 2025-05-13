import 'package:race_tracker/model/segment_record.dart';

class SegmentRecordDto {
  static Map<String, dynamic> toJson(SegmentRecord record) {
    return {
      'bib': record.bib,
      if (record.finishTime != null) 'finishTime': record.finishTime!.toIso8601String(),
      'fullName': record.fullName,
      'segment': record.segment.name, // Save enum as string
      if (record.startTime != null) 'startTime': record.startTime!.toIso8601String(), 
    };
  }

  static SegmentRecord fromJson(Map<String, dynamic> json) {
    return SegmentRecord(
      bib: json['bib'],
       finishTime: json['finishTime'] != null ? DateTime.parse(json['finishTime']) : null,
      fullName: json['fullName'],
      segment: Segment.values.firstWhere((s) => s.name == json['segment']),
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
     
    );
  }
}
