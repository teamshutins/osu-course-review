// Implementation of App widget, which is the root widget of this entire application.

import 'package:flutter/material.dart';
import 'screens/course_description.dart';
import 'screens/course_search.dart';


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSU Course Review',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      // set initialRoute to '/course' to load CourseDescriptionScreen      
      initialRoute: '/',
      routes: {
        '/': (context) => CourseSearch(),
        '/course': (context) => CourseDescriptionScreen(title: 'OSU Course Review')              
      }         
    );
  }
}



