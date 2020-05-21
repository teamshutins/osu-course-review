import 'package:flutter/material.dart';
import '../prototype/styled_container.dart';

class Result extends StatelessWidget {
  final course;
  final Function _goToCourse;  

  Result(this.course, this._goToCourse);

  StyledContainer _sectionListBackground = SectionListBackground(20.00, Colors.blue, Colors.yellow);

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToCourse,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _sectionListBackground.render(),
          //SectionContainer(_sectionListBackground),
          Text(
            '${course['title']}_${course['section']} ${course['instructor']['fullName']}',
            style: TextStyle(fontSize: 20)
          ),
        ],
      ),
      /*child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange, Colors.orange]
          ),
        ),
        child: Text(
          '${course['title']}_${course['section']} ${course['instructor']['fullName']}',
          style: TextStyle(fontSize: 20)
        ),
      ),*/
    );
  }
}

class SectionContainer extends StatelessWidget {

  final StyledContainer sectionListBackground;

  const SectionContainer(this.sectionListBackground);

  @override
  Widget build(BuildContext context) {
    sectionListBackground.clone();
    sectionListBackground.render();
    return Container();
  }
}