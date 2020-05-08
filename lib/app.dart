// Implementation of App widget, which is the root widget of this entire application.

import 'package:flutter/material.dart';
import 'screens/course_description.dart';
import 'screens/search_page.dart';
import 'screens/sections_page.dart';

//App widget points to the different sections of the app
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSU Course Review',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/sectionsPage',
      routes: {
        '/courseDescription': (context) => CourseDescriptionScreen(title: 'OSU Course Review'),
        '/searchPage': (context) => SearchPage(),
        '/sectionsPage': (context) => SectionsPage(),
      },
    );
  }
}
