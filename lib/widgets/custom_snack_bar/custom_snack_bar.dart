import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {
        Key? key,
        required this.content,
        required this.button,
      }) : super(key: key);

  final String content;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
