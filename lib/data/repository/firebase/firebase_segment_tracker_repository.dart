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

  Future<String> getActiveRaceId() async {
    final raceId = await _raceRepository.getCurrentRaceId();
    if (raceId == null) throw Exception("No active race found");
    return raceId;
  }
  
  @override
  Future<void> startSegment(String fullName, String bib, Segment segment) async {

    final raceId = await getActiveRaceId();

    if (!await _isRaceOngoing(raceId)) {
      throw Exception("Race is not ongoing");
    }

    final record = SegmentRecord(
      bib: bib,
      fullName: fullName,
      segment: segment,
      startTime: DateTime.now(),
    );

    final segmentRef = _db.child('race_segments/$raceId/${segment.name}/$bib');
    await segmentRef.set(SegmentRecordDto.toJson(record)); 
  }

  @override
  Future<void> finishSegment(String bib, Segment segment) async {
    final raceId = await getActiveRaceId();
    final finishTime = DateTime.now().toIso8601String();
    final finishRef = _db.child('race_segments/$raceId/${segment.name}/$bib/finishTime');
    await finishRef.set(finishTime);
  }

  @override
  Future<void> startAllParticipantsForSegment( Segment segment) async {
    final raceId = await getActiveRaceId();
    if (!await _isRaceOngoing(raceId)) {
      throw Exception("Race is not ongoing");
    }

    final List<Participant> participants = await _participantRepository.getParticipants();

    final segmentRef = _db.child('race_segments/$raceId/${segment.name}');

    for (final participant in participants) {
      final record = SegmentRecord(
        bib: participant.bib,
        fullName: '${participant.firstName} ${participant.lastName}',
        segment: segment,
        startTime: DateTime.now(),
      );

      await segmentRef.child(participant.bib.toString()).set(SegmentRecordDto.toJson(record));
    }
  }

  @override
  Future<void> unTrackStart( String bib, Segment segment) async {
    final raceId = await getActiveRaceId();
    final segmentStartRef = _db.child('race_segments/$raceId/$segment/$bib/startTime');
    await segmentStartRef.remove();
  }

  @override
  Future<void> unTrackFinish(String bib, Segment segment) async {
    final raceId = await getActiveRaceId();
    final segmentFinishRef = _db.child('race_segments/$raceId/$segment/$bib/finishTime');
    await segmentFinishRef.remove();
  }

}
