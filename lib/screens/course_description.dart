// Implementation of the "Course Description Screen". This screen displays the description of a specific course.
// It also shows a list of course reviews. The review data is coming from DB (Google Firebase).
// source1: https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr
// source2: https://bezkoder.com/dart-flutter-parse-json-string-array-to-object-list/
// source3: https://medium.com/@muddassirm/load-json-data-in-flutter-in-different-ways-e3312e6a317a


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'course_search.dart';
import '../models/id_section.dart';
import '../models/course_info.dart';
import '../components/reviewentry.dart';
import '../components/search_results.dart';

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
    // Taka: We use FutureBuilder because we will use a future value.
    // (i.e. courseInfoList() returns the future value.)
    return FutureBuilder<List<CourseInfo>>(
      future: courseInfoList(), 

      // Taka: snapshot represents the list of course info in this case.
      builder: (context, snapshot) {

        if (snapshot.hasData) {  
          int courseIndex = 0;
          String courseId = idAndSection.courseId;  //ex. "CS161"
          int sectionIndex = 0;
          int sectionNum = idAndSection.sectionNumber;  //ex. 400

          // Taka: Find where in the course info list the course which the user specifies exists.
          while (snapshot.data[courseIndex].id != courseId) {
            courseIndex++;
          }

          // Taka: Find where in the section list the section which the user specifies exists.
          while (snapshot.data[courseIndex].sections[sectionIndex].sectionNumber != sectionNum) {
            sectionIndex++;
          }        

          String courseTitle = '${snapshot.data[courseIndex].title} ${snapshot.data[courseIndex].name}';
          String courseSection = 'Section: ${snapshot.data[courseIndex].sections[sectionIndex].sectionNumber}';
          String courseDescription = 'Description: ${snapshot.data[courseIndex].description}';
          String instructorName = 'Instructor: ${snapshot.data[courseIndex].sections[sectionIndex].instructor.firstName} ${snapshot.data[courseIndex].sections[sectionIndex].instructor.lastName}';
          
          return SafeArea(
            // Taka: SingleChildScrollView makes the entire screen scrollable.
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0,),

                  courseInfoTextsAlign(courseTitle, true, 32),

                  SizedBox(height: 20.0,),

                  courseInfoTextsAlign(courseSection, false, 24),

                  SizedBox(height: 20.0,),

                  courseInfoTextsAlign(courseDescription, false, 24),
                  
                  SizedBox(height: 20.0,),

                  courseInfoTextsAlign(instructorName, false, 24),
                  
                  SizedBox(height: 20.0,),

                  // Taka: When tapping this button, the popup or another screen to write a review will show up.
                  WriteReviewButton(courseId: idAndSection.courseId),

                  SizedBox(height: 20.0,),
                  
                  // Taka: This is to retrieve the review data from DB (Google Firebase).
                  StreamBuilder(
                    // Taka: We should start a new collection in Firebase Database and replace the collection name here.
                    stream: Firestore.instance.collection('test_data').where("id", isEqualTo: idAndSection.courseId).snapshots(),
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
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }

  Widget courseInfoTextsAlign(String courseInfoText, bool isCourseTitle, double fontSize) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(                
        child: Text(
          courseInfoText,
          style: TextStyle(color: Colors.black, fontWeight: isCourseTitle ? FontWeight.bold : null, fontSize: fontSize,)
        ),
      ),
    );
  }
  
  //Taka: This function parses the JSON file and returns a list of course information
  Future<List<CourseInfo>> courseInfoList() async {
    String jsonString = await rootBundle.loadString('assets/course_info.json');
    
    var jsonResponse = json.decode(jsonString);
    var courseList = jsonResponse as List;
    
    List<CourseInfo> infoList = courseList.map((course) => CourseInfo.fromJson(course)).toList();
    
    return infoList;
  }
}


// Taka: This widget implements the button to display a popup/screen to write a review.
class WriteReviewButton extends StatelessWidget {
  
  final String courseId;
  WriteReviewButton({Key key, this.courseId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: 200,
        height: 50,
        child: RaisedButton(
          child: Text('WRITE REVIEW', style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Colors.orange,
          // Taka: Show the review entry form popup.
          onPressed: () {
            // Taka: Passing the courseId because the form needs to uplodad the info to DB.
            showDialog(context: context, builder: (BuildContext context) => CustomDialog(courseId: courseId));
          },
        ),
      ),
    );
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
          return showReviewListTile(post);
        },
      ),
    );
  }

  Widget showReviewListTile(post) {
    return ListTile(
      title: Text( post['comment'] ),
      subtitle: Text( post['name'] ),
    );
  }
}