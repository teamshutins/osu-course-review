import 'package:flutter/material.dart';

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
