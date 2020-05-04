// Implementation of the "Course Description Screen". This screen displays the description of a specific course.
// It also shows a list of course reviews. The review data is coming from DB (Google Firebase).
// source: https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course_info.dart';

// Taka: Root widget of this screen.
class CourseDescriptionScreen extends StatelessWidget {
  
  final String title;
  CourseDescriptionScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 36.0,),          
          // Taka: Currently, nothing happens when tapping the back arrow.
          // (It should go back to the previous screen.)
          onPressed: () {},
        ),
        centerTitle: true, 
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 32)),
      ),
      body: Description(),
    );
  }
}

// Taka: This widget is to display the course description + a list of course reviews.
class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CourseInfo>>(
      future: courseInfoList(), 
      builder: (context, snapshot) {

        if (snapshot.hasData) {  
          int courseIndex = 0;
          String courseId = "CS225";  // do not hard-code
          int sectionIndex = 0;
          int sectionNum = 400;       // do not hard-code

          while (snapshot.data[0].id != courseId) {
            courseIndex++;
          }

          while (snapshot.data[courseIndex].sections[sectionIndex].sectionNumber != sectionNum) {
            sectionIndex++;
          }        

          return SafeArea(
            // Taka: SingleChildScrollView makes the entire screen scrollable.
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
                      // Taka: For now, I just hard-coded the string. 
                      // This will be later replaced by the string data read from JSON file.
                      child: Text(
                        "${snapshot.data[courseIndex].title} ${snapshot.data[courseIndex].name}",
                      //  'CS 161 Introduction to Computer Science I', 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32,)
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // Taka: We will replace the string later.
                      child: Text(
                        'Section: ${snapshot.data[courseIndex].sections[sectionIndex].sectionNumber}', 
                        style: TextStyle(color: Colors.black, fontSize: 24)
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // Taka: We will replace the string later.
                      child: Text(
                        'Description: ${snapshot.data[courseIndex].description}', 
                        style: TextStyle(color: Colors.black, fontSize: 24)
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // Taka: We will replace the string later.
                      child: Text(
                        'Instructor: ${snapshot.data[courseIndex].sections[sectionIndex].instructor.firstName} ${snapshot.data[courseIndex].sections[sectionIndex].instructor.lastName}', 
                        style: TextStyle(color: Colors.black, fontSize: 24)
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  // Taka: When tapping this button, the popup or another screen to write a review will show up.
                  WriteReviewButton(),

                  SizedBox(height: 20.0,),
                  
                  // Taka: This is to retrieve the review data from DB (Google Firebase).
                  StreamBuilder(
                    stream: Firestore.instance.collection('test_data').where("id", isEqualTo: "CS161").snapshots(),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: 200,
        height: 50,
        child: RaisedButton(
          child: Text('WRITE REVIEW', style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Colors.orange,
          // For now, nothing happens when tapped.
          onPressed: () {
            
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
          return ListTile(
            title: Text(
              post['comment']
            ),
            subtitle: Text(
              post['name']
            ),
          );
        },
      ),
    );
  }
}

    