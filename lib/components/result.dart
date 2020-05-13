import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final course;
  final Function _goToCourse;  

  Result(this.course, this._goToCourse);

  @override 
  Widget build(BuildContext context) {
//    print(course);
    return InkWell(
      onTap: _goToCourse,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange, Colors.orange]
          ),
        ),
        child: Text(
          'Section ${course['sectionNumber']} ${course['instructor']['firstName']} ${course['instructor']['lastName']}',
          style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}