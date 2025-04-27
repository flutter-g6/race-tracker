import 'package:race_tracker/model/participant.dart';

class ParticipantDto {
  static Map<String, dynamic> toJson(Participant participant) {
    return {
      'bib': participant.bib,
      'firstName': participant.firstName,
      'lastName': participant.lastName,
      'age': participant.age,
      'gender': participant.gender,
    };
  }

  static Participant fromJson( Map<String, dynamic> json, String id) {
    return Participant(
      id: id,
      bib: json['bib'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
