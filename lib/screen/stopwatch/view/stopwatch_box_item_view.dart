import 'package:flutter/material.dart';
///-
import 'package:flutter_svg/flutter_svg.dart';
///-
import 'package:spend_time/config/config.dart';

class StopwatchBoxItemView extends StatelessWidget {
  const StopwatchBoxItemView(
      {
        Key? key,
        required this.layout,
        this.icon,
        this.title,
        required this.onPressed,
      }) : super(key: key);

  final CustomLayoutInfo layout;
  final Widget? icon;
  final String? title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          return const Color(0xFFEEF0F6);
        }),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/stopwatch_folder_icon.svg'),
          SizedBox(width: 10.0 * layout.widthPercent),
          Text(title ?? '제목 없음', style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
              fontSize: 16.0 * layout.fontPercent
          ),)
        ],
      ),
    );
  }
}
