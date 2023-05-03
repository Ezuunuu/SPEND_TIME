import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.width, required this.height, required this.backgroundColor, this.title, this.content, this.button}) : super(key: key);

  final double width;
  final double height;

  final Color backgroundColor;

  final Widget? title;
  final Widget? content;

  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.only(top: 26.0, left: 12.0, right: 12.0, bottom: 24.0),
        alignment: Alignment.topLeft,
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: title ?? Container(),
            ),
            const SizedBox(height: 8.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: content ?? Container(),
            ),
            const SizedBox(height: 30.0,),
            button ?? Container()
          ],
        ),
      ),
    );
  }
}
