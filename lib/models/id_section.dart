// This class is used for carrying objects needed for the page navigation

class IdAndSection {

  final String courseId;
  final int sectionNumber;
  final List<dynamic> results;  // storing a course search result

  IdAndSection({this.courseId, this.sectionNumber, this.results});
  
}