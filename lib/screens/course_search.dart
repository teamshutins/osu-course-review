// import official
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// import custom
import '../components/search_results.dart';

class CourseSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CourseSearchState();
  }
}

class CourseSearchState extends State<CourseSearch> {
  String _titleQuery = '';
  String _instructorQuery = '';
  List<dynamic> _courseCatalog = [];
  var _results = [];

  void loadCourses() async {
    _courseCatalog = jsonDecode(await rootBundle.loadString('assets/course_info.json'));

    // assign _courseCatalog again inside setState so Flutter knows to redraw widgets that use _courseCatalog 
    setState(() {
      _courseCatalog = _courseCatalog;
    });    
  } 

  @override
  void initState() {
    super.initState();
    loadCourses(); 
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
      if (_titleQuery == '' && _instructorQuery == '') {    // set _results to empty list if search input fields are empty
        _results = [];
      }
      else if (_titleQuery != '' && _instructorQuery != '') {     // search by title AND instructor
        // #TODO
      }
      else if (_titleQuery != '' && _instructorQuery == '') {     // search by title
        _results = _courseCatalog.where((course) => course['title'].toLowerCase().contains(_titleQuery.toLowerCase())).toList();          
      }
      else if (_titleQuery == '' && _instructorQuery != '') {     // search by instructor
        // #TODO
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
            child: _results.length!=0? Text("${_results[0]["title"]} ${_results[0]["name"]}", style: TextStyle(color: Colors.black, fontSize: 28)): null,
          ),
          Container(
            child: _results.length!=0? SearchResults(_results): null,
          ),
        ]
      )
    );
  }
}