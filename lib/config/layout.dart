import 'package:flutter/material.dart';

class Layout {

  /// DO NOT EDIT THIS!
  final standardWidth = 360;
  final standardHeight = 640;
  /// DO NOT EDIT THIS!

  final BuildContext context;
  var appBarSize = 0.0;

  Layout(this.context);

  get fullWidth => MediaQuery.of(context).size.width;
  get fullHeight => MediaQuery.of(context).size.height;
  get fullLayoutHeight => MediaQuery.of(context).size.height - appBarSize;

  get widthPercent => fullWidth / standardWidth;
  get heightPercent => fullHeight / standardHeight;

  get fontSize => fullWidth / standardWidth;
}