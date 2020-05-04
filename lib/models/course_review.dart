class CourseReview {

  final String id;
  final String name; 
  final String comment;

  CourseReview({this.id, this.name, this.comment});
  
  factory CourseReview.fromMap(Map<String, dynamic> post) {
    return CourseReview(
      id: post['id'],
      name: post['name'],
      comment: post['comment'],
    );
  }
}