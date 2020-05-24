import 'package:flutter/material.dart';

// This class defines an abstract interface that is common to all types of button builders.
abstract class ButtonBuilderBase {

  RaisedButton getButton() {
    return RaisedButton(
      child: getText(),
      color: getColor(),
      onPressed: getFunction(),
    );
  }

  Text getText();
  Color getColor();
  VoidCallback getFunction();
}

// This concrete builder provides a specific implementation of the construction steps
// to create the search button on the course search screen. 
class SearchButtonBuilder extends ButtonBuilderBase {
  
  VoidCallback function;
  SearchButtonBuilder({this.function});

  @override
  Text getText() {
    return Text('Find course');
  }

  @override
  Color getColor() {
    return Colors.amber;
  }

  @override
  VoidCallback getFunction() {
    return function;
  }
}

// This is another concrete builder to be used for the write review button on the course description screen. 
class ReviewButtonBuilder extends ButtonBuilderBase {
  
  VoidCallback function;
  ReviewButtonBuilder({this.function});

  @override
  Text getText() {
    return Text('WRITE REVIEW', style: TextStyle(color: Colors.white, fontSize: 24));
  }

  @override
  Color getColor() {
    return Colors.orange;
  }

  @override
  VoidCallback getFunction() {
    return function;
  }
}