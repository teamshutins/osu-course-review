import 'package:flutter/material.dart';

abstract class ButtonBuilderBase {
  RaisedButton getButton() {
    return RaisedButton(
      elevation: getElevation(),
      padding: getPadding(),
      shape: getShape(),
      child: getText(),
      color: getColor(),
      onPressed: getFunction(),
    );
  }

  double getElevation();
  EdgeInsetsGeometry getPadding();
  ShapeBorder getShape();
  Text getText();
  Color getColor();
  VoidCallback getFunction();
}

class SearchButtonBuilder extends ButtonBuilderBase {
  VoidCallback function;
  SearchButtonBuilder({this.function});

  @override
  double getElevation() {
    return 15.0;
  }

  @override
  EdgeInsetsGeometry getPadding() {
    return null;
  }

  @override
  ShapeBorder getShape() {
    return null;
  }

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
  double getElevation() {
    return 35.0;
  }

  @override
  ShapeBorder getShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200.0),
        side: BorderSide(color: Colors.orange[300], width: 5.0));
  }

  @override
  EdgeInsetsGeometry getPadding() {
    return EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0);
  }

  @override
  Text getText() {
    return Text('WRITE REVIEW',
        style: TextStyle(color: Colors.white, fontSize: 30));
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
