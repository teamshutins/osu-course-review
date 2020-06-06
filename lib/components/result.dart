import 'package:flutter/material.dart';
//import '../models/id_section.dart';

import '../builder/result_text_builder.dart';


class Result extends StatelessWidget {
  final course;
  final Function _goToCourse;  

  Result(this.course, this._goToCourse);

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToCourse,
      child: Container(
        padding: const EdgeInsets.all(10),        
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.orangeAccent),
          ),                  
        ),
        child: ResultTextBuilder(
          title: course['title'],
          section: course['section'],
          instructor: course['instructor']['fullName'],
          fontSize: 20,          
        ).buildResultText(),
      ),
    );
  }
}