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
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amber,
            width: 1,
          ),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFD3D3D3)]),
        ),
        child: ResultTextBuilder(
                title: course['title'],
                section: course['section'],
                instructor: course['instructor']['fullName'],
                fontSize: 20)
            .buildResultText(),
      ),
    );
  }
}

class NullResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin:const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text("Search not found, please try again",
        style: TextStyle(color: Colors.red, fontSize: 15)),
      )
    );
  }
}