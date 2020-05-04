import 'instructor.dart';

class Section {

  final int sectionNumber;
  final Instructor instructor;

  Section({this.sectionNumber, this.instructor});
  
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionNumber: json['sectionNumber'] as int,
      instructor: Instructor.fromJson(json['instructor']),
    );
  }
}