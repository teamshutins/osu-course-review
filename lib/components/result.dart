import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final course;
  final Function _testTap;

  Result(this.course, this._testTap);

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _testTap,
      child: Container(
        padding: const EdgeInsets.all(6),        
        child: Text(
          '${course['title']}',
          style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}