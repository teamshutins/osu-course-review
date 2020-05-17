
// import offical 
import 'package:flutter/material.dart';

// import custom 
import './result.dart';
import '../screens/course_description.dart';
import '../models/id_section.dart';

class SearchResults extends StatefulWidget {
  final List<dynamic> results;  

  SearchResults(this.results);

  @override
  State<StatefulWidget> createState() => new _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {    
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.results[0]["sections"].length,
        itemBuilder: (BuildContext context, int index) {
          return Result(
            widget.results[0]["sections"][index],
            //Taka: passing an anonymous function instead of the pre-defined _goToCourse
            () {
              final IdAndSection idAndSecNum = IdAndSection(
                courseId: widget.results[0]["id"], 
                sectionNumber: widget.results[0]["sections"][index]["sectionNumber"],
                results: widget.results
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseDescriptionScreen(idAndSection: idAndSecNum)),
              );
            }  
          );
        }      
      )
    );
  }
}