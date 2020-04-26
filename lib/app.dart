// Implementation of App widget, which is the root widget of this entire application.

import 'package:flutter/material.dart';
import 'screens/course_description.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSU Course Review',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      
      // Taka: Refers to course_description.dart file
      home: CourseDescriptionScreen(title: 'OSU Course Review'),
    );
  }
}