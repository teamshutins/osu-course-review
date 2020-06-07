// Parse the JSON file to create a CourseInfo object.
// This class depends on a Section object.

import 'section.dart';

class CourseInfo {

  final String id;
  final String title; 
  final String name;
  final List<Section> sections;
  final String description;

  CourseInfo({this.id, this.title, this.name, this.sections, this.description});
  
  // Parse JSON to create a CourseInfo object.
  factory CourseInfo.fromJson(Map<String, dynamic> json) {

    // Use a map fuction and the Section class's factory method to build a list of sections.
    var secObjJson = json['sections'] as List;
    List<Section> _sections = secObjJson.map((secJson) => Section.fromJson(secJson)).toList();

    return CourseInfo(
      id: json['id'] as String,
      title: json['title'] as String,
      name: json['name'] as String,
      sections: _sections,
      description: json['description'] as String,
    );
  }
}