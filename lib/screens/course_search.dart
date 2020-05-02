import 'package:flutter/material.dart';
import '../components/results.dart';

class CourseSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: Column(
        children: [
          Container(              
            margin: const EdgeInsets.fromLTRB(0, 25.0, 0, 0),   
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
            alignment: Alignment.center,            
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Course title',
                    ),                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Instructor',
                    ),                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Term',
                    ),                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: RaisedButton(
                    onPressed: () {
                      // list search results below
                    },
                    child: Text('Find course'),
                  ),
                ),
              ],
            )
            
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
            alignment: Alignment.center,
            child: SearchList()
          ),
        ]
      )
    );
  }
}