import 'package:flutter/material.dart';
import 'package:spend_time/config/config.dart';

class MyReportView extends StatelessWidget {
  const MyReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("MyReport View");
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 40.0,
          ),
          Text(
            '21년 12월 28일 수요일',
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
              fontSize: 10,
            ),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
