// A class to represent a single course review.

class CourseReview {

  final String id;
  final String name; 
  final String comment;

  CourseReview({this.id, this.name, this.comment});
  
  // This will be used to parse the course review data retrieved from the database (Firebase).
  factory CourseReview.fromMap(Map<String, dynamic> post) {
    return CourseReview(
      id: post['id'],
      name: post['name'],
      comment: post['comment'],
    );
  }
}