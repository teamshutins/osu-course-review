// This class is used for carrying objects needed for the page navigation

class IdAndSection {

  final String courseId;
  final int sectionNumber;
  final String courseTitle;
  final String courseName;
  final String courseDescription;
  final Map<String, dynamic> courseInstructor;
  final List<dynamic> results;  // storing a course search result

  IdAndSection({
    this.courseId, 
    this.courseName, 
    this.courseDescription, 
    this.sectionNumber, 
    this.results, 
    this.courseTitle, 
    this.courseInstructor 
  });  
}