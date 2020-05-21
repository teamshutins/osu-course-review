import 'package:flutter/material.dart';

abstract class BaseButton {

  Color color;
  String buttonTitle;
  double height;
  double width;
  Function closure;

  BaseButton(this.color, this.buttonTitle, this.height, this.width, );

  BaseButton.clone(BaseButton source) {
    color = source.color;
  }

  BaseButton clone();

  void randomiseProperties();

  Widget render();
}


class Circle extends BaseButton {

  double radius;

  Circle(Color color, this.radius) : super(color);

  Circle.initial() : super(Colors.black) {
    radius = 50.0;
  }

  Circle.clone(Circle source) : super.clone(source) {
    radius = source.radius;
  }

  @override
  BaseButton clone() {
    return Circle.clone(this);
  }

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
    radius = random.integer(50, min: 25).toDouble();
  }

  @override
  Widget render() {
    return SizedBox(
      height: 120.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 2 * radius,
          width: 2 * radius,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}