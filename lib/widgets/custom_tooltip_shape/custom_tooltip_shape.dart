import 'package:flutter/material.dart';

class CustomTooltipShape extends ShapeBorder {
  const CustomTooltipShape({this.usePadding = true, required this.radius, this.taleLocation = 10});
  final bool usePadding;
  final double radius;
  final double taleLocation;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(top: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft - const Offset(0, -20), rect.bottomRight);
    return Path()..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.topCenter.dx - taleLocation, rect.topCenter.dy)
      ..relativeLineTo(10, -13)
      ..relativeLineTo(10, 13)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}