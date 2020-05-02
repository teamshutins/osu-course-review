// Implementation of the "Course Section Screen". This screen displays the different
// sections of the user specified course as well as the professor that teaches each section.

import 'package:flutter/material.dart';

class CourseSectionScreen extends StatelessWidget {
  @override
  Widget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS 161 Introduction to Computer Science Sections'),
      ),
      body: _SectionsList(),
    );
  }

  Widget _SectionsList() {
    return new listView.builder(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.orange,
          child: const Center(child: Text('Section 1: Professor A')),
        ),
        Container(
          height: 50,
          color: Colors.orange,
          child: const Center(child: Text('Section 2: Professor B')),
        ),
        Container(
          height: 50,
          color: Colors.orange,
          child: const Center(child: Text('Section 3: Professor C')),
        ),
      ],
    );
  }
}
