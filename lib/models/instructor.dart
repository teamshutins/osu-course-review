class Instructor {

  final String firstName;
  final String lastName;
  
  Instructor({this.firstName, this.lastName});
  
  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
}