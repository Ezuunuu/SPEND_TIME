import 'package:flutter/material.dart';
import 'package:spend_time/config/config.dart';

class StopwatchAlarm {
  StopwatchAlarm({required this.layout});
  final CustomLayoutInfo layout;

  late List<Widget> alarmNameList;

  getList() {
    alarmNameList = [
      Center(
        child: Text('기본 알림음', style: TextStyle(
          fontFamily: 'SUIT',
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
          fontSize: 18.0 * layout.fontPercent,
        ),),
      ),
      Center(
        child: Text('진동', style: TextStyle(
          fontFamily: 'SUIT',
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
          fontSize: 18.0 * layout.fontPercent,
        ),),
      ),
      Center(
        child: Text('짧고 깔끔한', style: TextStyle(
          fontFamily: 'SUIT',
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
          fontSize: 18.0 * layout.fontPercent,
        ),),
      ),
      Center(
        child: Text('낮게 울리는', style: TextStyle(
          fontFamily: 'SUIT',
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
          fontSize: 18.0 * layout.fontPercent,
        ),),
      ),
      Center(
        child: Text('높고 청명한', style: TextStyle(
          fontFamily: 'SUIT',
          fontWeight: FontWeight.w500,
          color: const Color(0xFF000000),
          fontSize: 18.0 * layout.fontPercent,
        ),),
      ),
    ];
  }
}