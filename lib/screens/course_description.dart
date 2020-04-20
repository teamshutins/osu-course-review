// https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDescriptionScreen extends StatelessWidget {
  
  final String title;
  CourseDescriptionScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 36.0,),
          onPressed: () {},
        ),
        centerTitle: true, 
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 32)),
      ),
      body: Description(),
    );
  }
}

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('test_data').snapshots(),
      builder: (context, snapshot) {     
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('CS161 Introduction to Computer Science I', style: TextStyle(color: Colors.black, fontSize: 32)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('Section: 400', style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('Description: blah blah blah', style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('Instructor: Tim Alcon', style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
                Container(
                  child: ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: RaisedButton(
                      child: Text('WRITE REVIEW', style: TextStyle(color: Colors.white, fontSize: 24)),
                      color: Colors.orange,
                      onPressed: () {},
                    ),
                  ),
                ),
                reviewList(snapshot),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget reviewList (AsyncSnapshot<dynamic> snapshot) {
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