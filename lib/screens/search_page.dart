// Implementation of the "Course Section Screen". This screen displays the different
// sections of the user specified course as well as the professor that teaches each section.

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('OSU Course Review',
            style: TextStyle(color: Colors.white, fontSize: 32)),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: InputDecoration(hintText: 'Course Name')),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Instructor',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Term',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.orange,
                child: Text('ENTER'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
