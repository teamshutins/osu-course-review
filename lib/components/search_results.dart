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
            itemCount: widget.results.length,
            itemBuilder: (BuildContext context, int index) {
              return Result(widget.results[index], () {
                final IdAndSection idAndSecNum = IdAndSection(
                    courseId: widget.results[index]["id"],
                    courseTitle: widget.results[index]["title"],
                    courseInstructor: widget.results[index]["instructor"],
                    sectionNumber: widget.results[index]["section"],
                    courseName: widget.results[index]["name"],
                    courseDescription: widget.results[index]["description"],
                    results: widget.results);
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.requestFocus(FocusNode());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CourseDescriptionScreen(idAndSection: idAndSecNum)),
                );
              });
            }));
  }
}
