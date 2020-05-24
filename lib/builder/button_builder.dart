import 'package:flutter/material.dart';


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