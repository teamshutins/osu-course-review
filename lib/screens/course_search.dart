// Source: https://flutterigniter.com/dismiss-keyboard-form-lose-focus/

// import official
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// import custom
import '../components/search_results.dart';

class CourseSearch extends StatefulWidget {  
  final List prevResults;
  CourseSearch({this.prevResults});

  @override
  State<StatefulWidget> createState() {
    return CourseSearchState();
  }
}

class CourseSearchState extends State<CourseSearch> {
  String _titleQuery = '';
  String _instructorQuery = '';
  List<dynamic> _courseCatalog = [];
  List<dynamic> _results = [];

  void loadCourses() async {
    List<dynamic> courseData = jsonDecode(await rootBundle.loadString('assets/course_info.json'));   
    List<dynamic> courseDataBySection = [];    

    for (Map<String, dynamic> course in courseData) {
      for (Map<String, dynamic> section in course['sections']) {
        Map<String, dynamic> tempCourse = {...course};
        tempCourse['section'] = section['sectionNumber'];
        tempCourse['instructor'] = section['instructor'];
        tempCourse['instructor']['fullName'] = '${section['instructor']['firstName']} ${section['instructor']['lastName']}';
        tempCourse['id'] = '${course['id']}_${section['sectionNumber']}';
        tempCourse.remove('sections');
        courseDataBySection.add(tempCourse);
      }
    }

    // assign _courseCatalog again inside setState so Flutter knows to redraw widgets that use _courseCatalog 
    setState(() {
      _courseCatalog = courseDataBySection;
      print(_courseCatalog);
    });    
  } 

  void loadPreviousResults() {
    if (widget.prevResults.length > 0) {
      setState(() {
        _results = widget.prevResults;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCourses(); 
    loadPreviousResults();
  }

  void handleTitleQuery(value) {
    setState(() {
      _titleQuery = value;
    });
  }

  void handleInstructorQuery(value) {
    setState(() {
      _instructorQuery = value;
    });
  }

  void handleSearch() {    
    setState(() {
      if (_titleQuery == '' && _instructorQuery == '') {    // set results to empty list if search input fields are empty
        _results = [];
      }
      else if (_titleQuery != '' && _instructorQuery != '') {     // search by title AND instructor
        _results = _courseCatalog.where((course) {
          bool instructorMatch = course['instructor']['fullName'].toLowerCase().contains(_instructorQuery.toLowerCase());
          bool titleMatch = course['title'].toLowerCase().contains(_titleQuery.toLowerCase());
          return instructorMatch && titleMatch;
        }).toList();
      }
      else if (_titleQuery != '' && _instructorQuery == '') {     // search by title
        _results = _courseCatalog.where((course) => course['title'].toLowerCase().contains(_titleQuery.toLowerCase())).toList();        
        print(_results);  
      }
      else if (_titleQuery == '' && _instructorQuery != '') {     // search by instructor
        _results = _courseCatalog.where((course) => course['instructor']['fullName'].toLowerCase().contains(_instructorQuery.toLowerCase())).toList();        
      }      
    });
  }
  
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
                    onChanged: handleTitleQuery,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Course title (ex: 161, CS162)',
                    ),                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    onChanged: handleInstructorQuery,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Instructor',
                    ),                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      handleSearch();
                    },
                    child: Text('Find course'),
                  ),
                ),
              ],
            )
            
          ),
          Container(
            child: SearchResults(_results),
          ),     
        ]
      )
    );
  }
}