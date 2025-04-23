class Participant {
  final String id;
  final String bib;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;

  Participant({
    required this.id,
    required this.bib,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
  });

  Participant copyWith({
    String? id,
    String? bib,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
  }) {
    return Participant(
      id: id ?? this.id,
      bib: bib ?? this.bib,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }
}
