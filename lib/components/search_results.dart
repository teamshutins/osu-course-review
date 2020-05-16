
// import offical 
import 'package:flutter/material.dart';

// import custom 
import './result.dart';

class SearchResults extends StatefulWidget {
  final List<dynamic> results;  

  SearchResults(this.results);

  @override
  State<StatefulWidget> createState() => new _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {    
  @override
  Widget build(BuildContext context) {
    void _goToCourse() {
      Navigator.pushNamed(context, '/course');
    } 

    return Expanded(
      child: ListView.builder(
        itemCount: widget.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Result(
            widget.results[index],
            _goToCourse  
          );
        }      
      )
    );
  }
}