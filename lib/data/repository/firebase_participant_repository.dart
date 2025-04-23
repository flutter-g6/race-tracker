import 'package:race_tracker/model/participant.dart';

class FirebaseParticipantRepository { // TODO: implement abstract repository
  // method to get all participants
  Future<List<Map<String, dynamic>>> index() async {
    // TODO: implement getting logic
    throw UnimplementedError();
  }
  
  // method to store a new participants
  Future<Participant> store(Map<String, dynamic> participant) async {
    // TODO: implement storing logic
    throw UnimplementedError();
  }

  // method to update a participants
  void update(String id, Map<String, dynamic> participant) async {
    // TODO: implement update logic
    throw UnimplementedError();
  } 

  // method to delete a participants
  void delete(String id) async {
    // TODO: implement delete logic
    throw UnimplementedError();
  }
}
