// Implementation of App widget, which is the root widget of this entire application.

import 'package:flutter/material.dart';
import 'screens/course_search.dart';


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    List prevResults = [];
    return MaterialApp(
 //     title: 'OSU Course Review',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      // set initialRoute to '/' to load the main serach Screen      
      initialRoute: '/',
      routes: {
        '/': (context) => CourseSearch(prevResults: prevResults),       
      }         
    );
  }
}



