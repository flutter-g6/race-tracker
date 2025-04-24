import 'package:firebase_database/firebase_database.dart';
import 'package:race_tracker/data/dto/segment_record.dart';
import 'package:race_tracker/data/repository/firebase/firebase_participant_repository.dart';
import 'package:race_tracker/data/repository/firebase/firebase_race_repository.dart';
import 'package:race_tracker/data/repository/segment_tracker_repository.dart';
import 'package:race_tracker/model/participant.dart';
import 'package:race_tracker/model/race.dart';
import 'package:race_tracker/model/segment_record.dart';

class FirebaseSegmentTrackerRepository extends SegmentTrackerRepository {
  final FirebaseRaceRepository _raceRepository = FirebaseRaceRepository();
  final FirebaseParticipantRepository _participantRepository = FirebaseParticipantRepository();
  final _db = FirebaseDatabase.instance.ref();

  Future<bool> _isRaceOngoing(String raceId) async {
    final status = await _raceRepository.getRaceStatus(raceId);
    return status == RaceStatus.ongoing;
  }

  @override
  Future<void> startSegment(String raceId, String bib, Segment segment) async {
    if (!await _isRaceOngoing(raceId)) {
      throw Exception("Race is not ongoing");
    }

    final record = SegmentRecord(
      bib: bib,
      segment: segment,
      startTime: DateTime.now(),
    );

    final segmentRef = _db.child('race_segments/$raceId/${segment.name}/$bib');
    await segmentRef.set(SegmentRecordDto.toJson(record)); 
  }

  @override
  Future<void> finishSegment(String raceId, String bib, Segment segment) async {
    final finishTime = DateTime.now().toIso8601String();
    final finishRef = _db.child('race_segments/$raceId/${segment.name}/$bib/finishTime');
    await finishRef.set(finishTime);
  }

  @override
  Future<void> startAllParticipantsForSegment(String raceId, Segment segment) async {
    if (!await _isRaceOngoing(raceId)) {
      throw Exception("Race is not ongoing");
    }

    final List<Participant> participants = await _participantRepository.getParticipants();

    final segmentRef = _db.child('race_segments/$raceId/${segment.name}');

    for (final participant in participants) {
      final record = SegmentRecord(
        bib: participant.bib,
        segment: segment,
        startTime: DateTime.now(),
      );

      await segmentRef.child(participant.bib).set(SegmentRecordDto.toJson(record));
    }
  }
}
