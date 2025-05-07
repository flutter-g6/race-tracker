  import 'package:flutter/foundation.dart';

  enum SportType { running, swimming, cycling }

  enum DisplayMode { list, grid, massStart }

  class ParticipantsTrackingProvider extends ChangeNotifier {
    SportType _selectedSport = SportType.running;
    DisplayMode _displayMode = DisplayMode.list;
    ParticipantRange _selectedRange = ParticipantRange(range: [1, 49], index: 0);
    final int totalParticipants = 250;
    final Set<int> _trackingParticipants = {};

    SportType get selectedSport => _selectedSport;
    DisplayMode get displayMode => _displayMode;
    ParticipantRange get selectedRange => _selectedRange;
    Set<int> get trackingParticipants => _trackingParticipants;

    List<ParticipantRange> get participantRanges {
      List<ParticipantRange> ranges = [];
      int start = 1;
      int index = 0;

      while (start <= totalParticipants) {
        int end = start + 49;
        if (end > totalParticipants) end = totalParticipants;
        ranges.add(ParticipantRange(range: [start, end], index: index));
        start = end + 1;
        index++;
      }

      return ranges;
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

    void startTrackingRange(int start, int end) {
      for (int i = start; i <= end; i++) {
        _trackingParticipants.add(i);
      }
      notifyListeners();
    }

    void stopTrackingRange(int start, int end) {
      for (int i = start; i <= end; i++) {
        _trackingParticipants.remove(i);
      }
      notifyListeners();
    }

    void clearAllTracking() {
      _trackingParticipants.clear();
      notifyListeners();
    }

    void setSelectedSport(SportType sport) {
      _selectedSport = sport;
      notifyListeners();
    }

    void setDisplayMode(DisplayMode mode) {
      _displayMode = mode;
      notifyListeners();
    }

    void setParticipantRange(ParticipantRange range) {
      _selectedRange = range;
      notifyListeners();
    }
  }

  class ParticipantRange {
    final List<int> range;
    final int index;

    ParticipantRange({required this.range, required this.index});
  }