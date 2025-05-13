import 'package:flutter/foundation.dart';
import 'package:race_tracker/data/repository/firebase/firebase_participant_repository.dart';
import '../../data/repository/participant_repository.dart';
import '../../model/participant.dart';
import '../../model/segment_record.dart';
import '../screens/tracker/widgets/display_mode_selector.dart';

class ParticipantsTrackingProvider extends ChangeNotifier {
  final ParticipantRepository _repository = FirebaseParticipantRepository();

  Segment _selectedSport = Segment.run; // Default first segment
  DisplayMode _displayMode = DisplayMode.list;
  final Set<int> _trackingParticipants = {};

  List<Participant> _participants = [];
  bool _isLoading = false;

  Segment get selectedSport => _selectedSport;
  DisplayMode get displayMode => _displayMode;
  Set<int> get trackingParticipants => _trackingParticipants;
  List<Participant> get participants => _participants;
  bool get isLoading => _isLoading;

  Future<void> fetchParticipants() async {
    _isLoading = true;
    notifyListeners();
    try {
      _participants = await _repository.getParticipants();
    } catch (error) {
      debugPrint('Error fetching participants: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedSport(Segment sport) {
    _selectedSport = sport;
    notifyListeners();
  }

  void setDisplayMode(DisplayMode mode) {
    _displayMode = mode;
    notifyListeners();
  }

  bool isTrackingParticipant(int participantNumber) {
    return _trackingParticipants.contains(participantNumber);
  }

  void startTrackingParticipant(int participantNumber) {
    _trackingParticipants.add(participantNumber);
    notifyListeners();
  }

  void stopTrackingParticipant(int participantNumber) {
    _trackingParticipants.remove(participantNumber);
    notifyListeners();
  }

  void clearAllTracking() {
    _trackingParticipants.clear();
    notifyListeners();
  }
}
