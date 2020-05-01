// Implementation of the "Course Description Screen". This screen displays the description of a specific course.
// It also shows a list of course reviews. The review data is coming from DB (Google Firebase).
// source: https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Taka: Root widget of this screen.
class CourseDescriptionScreen extends StatelessWidget {
  
  final String title;
  CourseDescriptionScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 36.0,),          
          // Taka: Currently, nothing happens when tapping the back arrow.
          // (It should go back to the previous screen.)
          onPressed: () {},
        ),
        centerTitle: true, 
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 32)),
      ),
      body: Description(),
    );
  }
}

// Taka: This widget is to display the course description + a list of course reviews.
class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Taka: SingleChildScrollView makes the entire screen scrollable.
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBoxes for spacing. We should refactor these ones.
            SizedBox(height: 20.0,),

            // Taka: I should also refactor all these Align widgets. They are just repetitive.
            Align(
              alignment: Alignment.centerLeft,
              child: Container(                
                // Taka: For now, I just hard-coded the string. 
                // This will be later replaced by the string data read from JSON file.
                child: Text(
                  'CS 161 Introduction to Computer Science I', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32,)
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Section: 400 [Use JSON file]', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Description: [Replaced by the Course Info read from JSON file]', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),

            SizedBox(height: 20.0,),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // Taka: We will replace the string later.
                child: Text('Instructor: Tim Alcon [Use JSON file]', style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),

            SizedBox(height: 20.0,),

            // Taka: When tapping this button, the popup or another screen to write a review will show up.
            WriteReviewButton(),

            SizedBox(height: 20.0,),
            
            // Taka: This is to retrieve the review data from DB (Google Firebase).
            StreamBuilder(
              stream: Firestore.instance.collection('test_data').snapshots(),
              builder: (context, snapshot) {
                // Taka: If there is at least one item in DB, build and show the list of reviews.
                if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {   
                  return ReviewList(snapshot: snapshot);
                }
                // Taka: If there is no item in DB, don't show anything.
                else {
                  return Container();
                }
              }
            )
          ],
        ),
      ),
    );
  }
}


// Taka: This widget implements the button to display a popup/screen to write a review.
class WriteReviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: 200,
        height: 50,
        child: RaisedButton(
          child: Text('WRITE REVIEW', style: TextStyle(color: Colors.white, fontSize: 24)),
          color: Colors.orange,
          // For now, nothing happens when tapped.
          // Navigator temporarily added by Kevin Lee
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchList()),
            );
          },
        ),
      ),
    );
  }
}


// Taka: This widget creates and displays a list of reviews. The list is scrollable.
class ReviewList extends StatelessWidget {

  final AsyncSnapshot<dynamic> snapshot;
  ReviewList({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          var post = snapshot.data.documents[index];
          return ListTile(
            title: Text(
              post['comment']
            ),
            subtitle: Text(
              post['name']
            ),
          );
        },
      ),
    );
  }
}

//Week 1 Code Kevin and Dylan

/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OSU Course Explorer',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        body: SearchList(),
      ),
    );
  }
}
*/

class SearchList extends StatefulWidget {
  SearchList({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList>
{
  Widget appBarTitle = new Text("OSU Course Review", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _isSearching;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    init();

  }

  void init() {
    _list = List();
    _list.add("CS 161");
    _list.add("CS 162");
    _list.add("CS 225");
    _list.add("CS 271");
    _list.add("CS 261");
    _list.add("CS 290");
    _list.add("CS 340");
    _list.add("CS 361");
    _list.add("CS 325");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _isSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact))
          .toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String  name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact))
          .toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Course number or professor...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

//Changes the state of the program to show the list of available courses while searching.
  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

//Changes the state of the program to clear the screen body and revert to the standard header if there is no active search.
  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("OSU Course Explorer", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchQuery.clear();
    });
  }

}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }
}

//Week 1 Code Kevin and Dylan End