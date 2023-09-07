


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<int>? pattern;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(body: Center(
        child:
        PatternLock(
          // color of selected points.
          selectedColor: Colors.red,
          // radius of points.
          pointRadius: 30,
          // whether show user's input and highlight selected points.
          showInput: true,
          // count of points horizontally and vertically.
          dimension: 3,
          // padding of points area relative to distance between points.
          relativePadding: 0.7,
          // needed distance from input to point to select point.
          selectThreshold: 25,
          // whether fill points.
          fillPoints: true,
          // callback that called when user's input complete. Called if user selected one or more points.
          onInputComplete: (List<int> input) {
            print("pattern is $input");
          },
        ),
      ),);
  }
}