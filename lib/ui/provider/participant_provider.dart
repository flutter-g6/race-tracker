import 'package:flutter/material.dart';

import 'package:race_tracker/model/participant.dart';
import '../../data/repository/participant_repository.dart';
import 'async_value.dart';

class ParticipantProvider extends ChangeNotifier {
  final ParticipantRepository _repository;
  AsyncValue<List<Participant>>? participantState;

  ParticipantProvider(this._repository) {
    fetchParticipant();
  }

  bool get isLoading =>
      participantState != null &&
      participantState!.state == AsyncValueState.loading;
  bool get hasData =>
      participantState != null &&
      participantState!.state == AsyncValueState.success;

  void fetchParticipant() async {
    try {
      participantState = AsyncValue.loading();
      notifyListeners();

      participantState = AsyncValue.success(
        await _repository.getParticipants(),
      );
      print(participantState?.data);
      
    } catch (error) {
      participantState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addParticipant(Participant participant) async {
    await _repository.addParticipant(participant);
    fetchParticipant();
  }

  void deleteBook(String id) async {
    await _repository.deleteParticipant(id);
    fetchParticipant();
  }

  void updateBook(Participant participant) async {
    await _repository.updateParticipant(participant);
    fetchParticipant();
  }
}
