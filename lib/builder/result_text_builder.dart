import 'package:flutter/material.dart';

// This is antoher implementation of the "builder" design pattern with a different approach.
// In this implementation, the constructor takes care of building products with different combinations 
// of four parameters.
// Then, the buildResultText() method returns a text object to display the course search results.
class ResultTextBuilder {
  final String title;
  final int section;
  final String instructor;
  final double fontSize;

  ResultTextBuilder({
    this.title,
    this.section,
    this.instructor,
    this.fontSize
  });

  Widget buildResultText() {
    return Text(
      '${title}_$section $instructor',
      style: TextStyle(fontSize: fontSize)
    );
  }
}