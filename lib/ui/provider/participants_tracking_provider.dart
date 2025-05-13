import 'package:flutter/foundation.dart';
import 'package:race_tracker/data/repository/firebase/firebase_participant_repository.dart';
import '../../data/repository/participant_repository.dart';
import '../../model/participant.dart';

enum SportType { running, swimming, cycling }

enum DisplayMode { list, grid, massStart }

class ParticipantsTrackingProvider extends ChangeNotifier {
  final ParticipantRepository _repository = FirebaseParticipantRepository();

  SportType _selectedSport = SportType.running;
  DisplayMode _displayMode = DisplayMode.list;
  final Set<int> _trackingParticipants = {};

  List<Participant> _participants = [];
  bool _isLoading = false;

  SportType get selectedSport => _selectedSport;
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

  void setSelectedSport(SportType sport) {
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
