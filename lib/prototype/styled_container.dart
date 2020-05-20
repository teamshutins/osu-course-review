import 'package:flutter/material.dart';

abstract class StyledContainer {

  double height;
  
  StyledContainer(this.height);

  StyledContainer.clone(StyledContainer source) {
    height = source.height;
  }

  StyledContainer clone();
  Widget render();
}

class SectionListBackground extends StyledContainer {

  Color color1;
  Color color2;

  SectionListBackground(double height, this.color1, this.color2) : super(height);

  SectionListBackground.clone(SectionListBackground source) : super.clone(source) {
    color1 = source.color1;
    color2 = source.color2;
  }

  @override
  StyledContainer clone() {
    return SectionListBackground.clone(this);
  }

  @override
  Widget render() {
    return Container(
      height: height,
      color: color2,
//      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepOrange, Colors.orange],
        ),
      ),
    );
  }
}