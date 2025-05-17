import 'package:race_tracker/model/race.dart';

class RaceDto {
  static Map<String, dynamic> toJson(Race race) {
    return {
      'status': race.status.name,
      'startTime': race.startTime?.toIso8601String(),
      'finishTime': race.finishTime?.toIso8601String(),
    };
  }

  static Race fromJson(Map<String, dynamic> json, String id) {
    return Race(
      id: id,
      status: RaceStatus.values.firstWhere((e) => e.name == json['status']),
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      finishTime:
          json['finishTime'] != null
              ? DateTime.parse(json['finishTime'])
              : null,
    );
  }
}
