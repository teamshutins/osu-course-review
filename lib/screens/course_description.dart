// Implementation of the "Course Description Screen". This screen displays the description of a specific course.
// It also shows a list of course reviews. The review data is coming from DB (Google Firebase).
// source1: https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr
// source2: https://bezkoder.com/dart-flutter-parse-json-string-array-to-object-list/
// source3: https://medium.com/@muddassirm/load-json-data-in-flutter-in-different-ways-e3312e6a317a


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'course_search.dart';
import '../models/id_section.dart';
import '../components/reviewentry.dart';
import '../builder/button_builder.dart';

// Taka: Root widget of this screen.
class CourseDescriptionScreen extends StatelessWidget {
  
  final IdAndSection idAndSection;
  CourseDescriptionScreen({Key key, this.idAndSection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 36.0,),          
          // Taka: Go back to the main screen.
          onPressed: () {  
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseSearch(prevResults: idAndSection.results)),
            );
          },
        ),
        centerTitle: true, 
        title: Text('OSU Course Review', style: TextStyle(color: Colors.white, fontSize: 32)),
      ),
      body: Description(idAndSection: idAndSection),
    );
  }
}

// Taka: This widget is to display the course description + a list of course reviews.
class Description extends StatelessWidget {

  final IdAndSection idAndSection;
  Description({Key key, this.idAndSection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBoxes for spacing. We should refactor these ones.
            SizedBox(height: 20.0,),
            
            // Taka: I should also refactor all these Align widgets. They are just repetitive.
            Align(
              alignment: Alignment.centerLeft,
              child: Container(                
                // Taka: Display the course title and name.
                child: Text(
                  "${idAndSection.courseTitle} ${idAndSection.courseName}",
                //  'CS 161 Introduction to Computer Science I', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32,)
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: Display the course's section number the user specifies.
                child: Text(
                  'Section: ${idAndSection.sectionNumber}', 
                  style: TextStyle(color: Colors.black, fontSize: 24)
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: Display the course description.
                child: Text(
                  'Description: ${idAndSection.courseDescription}', 
                  style: TextStyle(color: Colors.black, fontSize: 24)
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: Display the instructor's name of the section the user specifies.
                child: Text(
                  'Instructor: ${idAndSection.courseInstructor['fullName']}', 
                  style: TextStyle(color: Colors.black, fontSize: 24)
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            // Taka: When tapping this button, the popup or another screen to write a review will show up.
            WriteReviewButton(courseId: idAndSection.courseId),

            SizedBox(height: 20.0,),

            // Taka: This is to retrieve the review data from DB (Google Firebase).
            StreamBuilder(
              // Taka: We should start a new collection in Firebase Database and replace the collection name here.
              // David: find reviews list using courseTitle instead of courseId
              stream: Firestore.instance.collection('reviews').where("id", isEqualTo: idAndSection.courseId).orderBy('dateTime', descending:true).snapshots(),
              builder: (context, snapshot) {
                
                // Taka: If there is at least one item in DB, build and show the list of reviews.
                if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {                     
                  return ReviewList(snapshot: snapshot);
                }
                // Taka: If there is no item in DB, don't show anything.
                else {
                  return Container();
                }
              }
            )
          ],
        ),
      )
    );
  }         
}


// Taka: This widget implements the button to display a popup/screen to write a review.
class WriteReviewButton extends StatelessWidget {
  
  final String courseId;
  WriteReviewButton({Key key, this.courseId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    ReviewButtonBuilder reviewButton = ReviewButtonBuilder(function: () {buildShowDialog(context);});
    
    return Container(
      child: ButtonTheme(
        minWidth: 200,
        height: 50,
        child: reviewButton.getButton(),
      ),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) => CustomDialog(courseId: courseId));
  }
}


// Taka: This widget creates and displays a list of reviews. The list is scrollable.
class ReviewList extends StatelessWidget {

  final AsyncSnapshot<dynamic> snapshot;
  ReviewList({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          var post = snapshot.data.documents[index];
          return Card(
            color: Colors.orange[50],
            child: ListTile(
              title: Text(post['comment'], style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic)),
              subtitle: Container(
                alignment: Alignment.bottomRight, 
                child: Text(post['name'], style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16, fontStyle: FontStyle.italic)),
              ),
            ),
          );
        },
      ),
    );
  }
}