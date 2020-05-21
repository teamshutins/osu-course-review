import 'package:flutter/material.dart';
//import '../models/id_section.dart';

class Result extends StatelessWidget {
  final course;
  final Function _goToCourse;  

  Result(this.course, this._goToCourse);

  @override 
  Widget build(BuildContext context) {
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
          '${course['title']}_${course['section']} ${course['instructor']['fullName']}',
          style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}