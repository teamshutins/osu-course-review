// Parse the JSON file to create a Section object.
// This class depends on an Instructor object.

import 'instructor.dart';

class Section {

  final int sectionNumber;
  final Instructor instructor;

  Section({this.sectionNumber, this.instructor});
  
  // Parse JSON to create a Section object.
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionNumber: json['sectionNumber'] as int,
      instructor: Instructor.fromJson(json['instructor']),
    );
  }
}