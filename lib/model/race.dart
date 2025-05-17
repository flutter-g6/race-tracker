enum RaceStatus { notStarted, ongoing, finished }

class Race {
  final String id;
  final RaceStatus status;
  final DateTime? startTime;
  final DateTime? finishTime;

  Race({
    required this.id,
    required this.status,
    this.startTime,
    this.finishTime,
  });

  Race copyWith({
    RaceStatus? status,
    DateTime? startTime,
    DateTime? finishTime,
  }) {
    return Race(
      id: id,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      finishTime: finishTime ?? this.finishTime,
    );
  }
}
