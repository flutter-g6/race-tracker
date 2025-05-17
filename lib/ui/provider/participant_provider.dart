import 'package:flutter/material.dart';

import 'package:race_tracker/model/participant.dart';
import '../../data/repository/participant_repository.dart';
import 'async_value.dart';

class ParticipantProvider extends ChangeNotifier {
  final ParticipantRepository _repository;
  AsyncValue<List<Participant>>? participantState;

  ParticipantProvider(this._repository) {
    if (participantState == null) {
      fetchParticipant();
    }
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
    } catch (error) {
      participantState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void restoreParticipant(Participant participant) async {
    final oldData = participantState?.data ?? [];

    // Locally add back to the correct position based on bib
    final temp = List<Participant>.from(oldData)..add(participant);
    temp.sort((a, b) => int.parse(a.bib).compareTo(int.parse(b.bib)));

    participantState = AsyncValue.success(temp);
    notifyListeners();

    try {
      await _repository.restoreParticipant(participant);
    } catch (e) {
      participantState = AsyncValue.error(e);
      notifyListeners();
    }
  }

  void addParticipant(Participant participant) async {
    final oldData = participantState?.data ?? [];

    try {
      // 1. Add to backend and wait for full participant (with bib and id)
      await _repository.addParticipant(participant);

      // 2. Refetch only the last one from backend (or refetch all if needed)
      final freshList = await _repository.getParticipants();

      // 3. Add the new confirmed participant to local cache
      final temp = List<Participant>.from(oldData);
      final newOne = freshList.last;

      temp.add(newOne);
      participantState = AsyncValue.success(temp);
      notifyListeners();
    } catch (e) {
      participantState = AsyncValue.error(e);
      notifyListeners();
    }
  }

  void deleteParticipant(String id) async {
    final oldData = participantState?.data ?? [];

    // local update by store in temp variable
    final temp = List<Participant>.from(oldData)
      ..removeWhere((p) => p.id == id);
    participantState = AsyncValue.success(temp);
    notifyListeners();

    try {
      // fectch in background
      await _repository.deleteParticipant(id);
    } catch (e) {
      participantState = AsyncValue.error(e);
      notifyListeners();
    }
  }

  void updateParticipant(Participant participant) async {
    final oldData = participantState?.data ?? [];

    // local update by store in temp variable
    final temp = List<Participant>.from(oldData);
    final index = temp.indexWhere((p) => p.id == participant.id);
    if (index != -1) temp[index] = participant;
    participantState = AsyncValue.success(temp);
    notifyListeners();

    try {
      // fectch in background
      await _repository.updateParticipant(participant);
    } catch (e) {
      participantState = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
