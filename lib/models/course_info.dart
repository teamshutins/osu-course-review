import 'section.dart';

class CourseInfo {

  final String id;
  final String title; 
  final String name;
  final List<Section> sections;
  final String description;

  CourseInfo({this.id, this.title, this.name, this.sections, this.description});
  
  factory CourseInfo.fromJson(Map<String, dynamic> json) {

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