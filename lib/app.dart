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
      home: CourseDescriptionScreen(title: 'OSU Course Review'),
    );
  }
}