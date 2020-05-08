// Implements the section page of the app. This is the part of the app that the user is brought to
// when they choose a specific course. It shows the user all of the different sections of the course
// as well as who is teaching said course.

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_description.dart';

class SectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('CS 161: Introduction To Computer Science'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CourseDescriptionScreen(),
                      ),
                    );
                  },
                  child: Card(
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Section 1: Professor A',
                            style: TextStyle(fontSize: 18),
                          )))),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CourseDescriptionScreen(),
                      ),
                    );
                  },
                  child: Card(
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Section 2: Professor B',
                            style: TextStyle(fontSize: 18),
                          )))),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CourseDescriptionScreen(),
                      ),
                    );
                  },
                  child: Card(
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Section 3: Professor C',
                            style: TextStyle(fontSize: 18),
                          )))),
            ],
          ),
        ));
  }
}
