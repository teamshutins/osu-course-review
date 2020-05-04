// Parse the JSON file to create an Instructor object.

class Instructor {

  final String firstName;
  final String lastName;
  
  Instructor({this.firstName, this.lastName});
  
  // Parse JSON to create an Instructor Object.
  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
}