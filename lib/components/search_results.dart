// import offical
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

// import custom
import './result.dart';
import '../screens/course_description.dart';
import '../models/id_section.dart';
import 'result.dart';

class SearchResults extends StatefulWidget {
  final List<dynamic> results;
  final bool isInit;

  SearchResults(this.results, this.isInit);

  @override
  State<StatefulWidget> createState() => new _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    int num = widget.results.length; 
    
    return Row(
          children: <Widget>[
            Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>(num == 0 && widget.isInit == false),
              widgetBuilder: (BuildContext context){
                return NullResult();
              },
              fallbackBuilder: (BuildContext context){
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.results.length,
                      itemBuilder: (BuildContext context, int index){
                        return Result(widget.results[index], () {
                          final IdAndSection idAndSecNum = IdAndSection(
                            courseId: widget.results[index]["id"],
                            courseTitle: widget.results[index]["title"],
                            courseInstructor: widget.results[index]["instructor"],
                            sectionNumber: widget.results[index]["section"],
                            courseName: widget.results[index]["name"],
                            courseDescription: widget.results[index]["description"],
                            results: widget.results);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => 
                                CourseDescriptionScreen(idAndSection: idAndSecNum)),
                             );
                        });
                      }));    
              },
            )
          ],
    );
        
  }
}