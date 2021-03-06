// Source: https://flutterigniter.com/dismiss-keyboard-form-lose-focus/

// import official
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import custom
import '../components/search_results.dart';
import '../builder/button_builder.dart';

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
  Firestore _firestore = Firestore.instance;
  bool isInit = true;  

  void loadCourses() async {   
    List<dynamic> courseDataBySection = [];   

    QuerySnapshot querySnapshot = await _firestore.collection('catalog').orderBy('id', descending: false).getDocuments();
    querySnapshot.documents.forEach((courseDoc) => courseDataBySection.add(courseDoc.data));      

    // assign _courseCatalog again inside setState so Flutter knows to redraw widgets that use _courseCatalog
    setState(() {
      _courseCatalog = courseDataBySection;
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
      if (_titleQuery == '' && _instructorQuery == '') {
        // set results to empty list if search input fields are empty
        _results = [];
      } else if (_titleQuery != '' && _instructorQuery != '') {
        // search by title AND instructor
        _results = _courseCatalog.where((course) {
          bool instructorMatch = course['instructor']['fullName']
              .toLowerCase()
              .contains(_instructorQuery.toLowerCase());
          bool titleMatch =
              course['title'].toLowerCase().contains(_titleQuery.toLowerCase());
          return instructorMatch && titleMatch;
        }).toList();
      } else if (_titleQuery != '' && _instructorQuery == '') {
        // search by title
        _results = _courseCatalog
            .where((course) => course['title']
                .toLowerCase()
                .contains(_titleQuery.toLowerCase()))
            .toList();
      } else if (_titleQuery == '' && _instructorQuery != '') {
        // search by instructor
        _results = _courseCatalog
            .where((course) => course['instructor']['fullName']
                .toLowerCase()
                .contains(_instructorQuery.toLowerCase()))
            .toList();
      }
    });

    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    SearchButtonBuilder searchButton = SearchButtonBuilder(function: () {
      searchMethod(context);
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text('OSU Course Review', style: TextStyle(color: Colors.white, fontSize: 32)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                    child: searchButton.getButton(),
                  ),
                ],)
              ),
            Row(children: [
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(color: Colors.black, height: 36,)
                ),
              ),
              Text("Search Results"),
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Divider(color: Colors.black, height: 36,)
                ),
              ),
            ]),
            Container(child: SearchResults(_results, isInit),),
          ])
        )
      )
    );
  }

  void searchMethod(BuildContext context) {
    handleSearch();

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }    
  }
}
