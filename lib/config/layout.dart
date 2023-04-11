import 'package:flutter/material.dart';

class Layout {

  /// DO NOT EDIT THIS!
  final standardWidth = 360;
  final standardHeight = 640;
  /// DO NOT EDIT THIS!

  final MediaQueryData mediaQueryData;
  var appBarSize = 0.0;

  Layout(this.mediaQueryData);

  get fullWidth => mediaQueryData.size.width;
  get fullHeight => mediaQueryData.size.height;
  get fullLayoutHeight => mediaQueryData.size.height - appBarSize;

  get widthPercent => fullWidth / standardWidth;
  get heightPercent => fullHeight / standardHeight;
  get fontPercent => fullWidth / standardWidth;
}