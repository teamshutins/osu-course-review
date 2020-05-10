import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  // String title;
  // String name;
  // String section;
  // String instructor;  

  // Result(this.title, this.name, this.section, this.instructor);
  final String title;
  final int color;
  final Function _testTap;

  Result(this.title, this.color, this._testTap);

  @override 
  Widget build(BuildContext context) {
    return InkWell(
            onTap: _testTap,
            child: Container(
              padding: const EdgeInsets.all(6),        
              color: Colors.amber[color],
              child: Text(
                'Test $title',
                style: TextStyle(fontSize: 20)
              ),
            ),
          );
  }
}