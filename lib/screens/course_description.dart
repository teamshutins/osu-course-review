// Implementation of the "Course Description Screen". This screen displays the description of a specific course.
// It also shows a list of course reviews. The review data is coming from DB (Google Firebase).
// source: https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return SafeArea(
      // Taka: SingleChildScrollView makes the entire screen scrollable.
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Taka: I should have refactored all these Align widgets. They are just repetitive.
            Align(
              alignment: Alignment.centerLeft,
              child: Container(                
                // Taka: For now, I just hard-coded the string. 
                // This will be later replaced by the string data coming from JSON file.
                child: Text('CS161 Introduction to Computer Science I', style: TextStyle(color: Colors.black, fontSize: 32)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Section: 400', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Description: blah blah blah', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Instructor: Tim Alcon', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),

            // Taka: When tapping this button, the popup or another screen to write a review will show up.
            WriteReviewButton(),

            // Taka: This is to retrieve the review data from DB (Google Firebase).
            StreamBuilder(
              stream: Firestore.instance.collection('test_data').snapshots(),
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
          onPressed: () {},
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