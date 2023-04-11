import 'package:flutter/material.dart';
import 'package:spend_time/config/config.dart';

class DevelopExampleView extends StatelessWidget {
  const DevelopExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = Layout(MediaQuery.of(context));
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(width: 200.0 * layout.widthPercent, height: 100.0 * layout.heightPercent,),
              SizedBox(width: 100.0 * layout.widthPercent, height: 200.0 * layout.heightPercent,),
              Text('ABCDEFG 가나다라마바사 12345 - 800',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 22.0 * layout.fontPercent,
                  ),
                  textAlign: TextAlign.center),
              Text('ABCDEFG 가나다라마바사 12345 - 700',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 22.0 * layout.fontPercent,
                  ),
                  textAlign: TextAlign.center),
              Text('ABCDEFG 가나다라마바사 12345 - 500',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 22.0 * layout.fontPercent,
                  ),
                  textAlign: TextAlign.center),
              Text('ABCDEFG 가나다라마바사 12345 - 400',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 22.0 * layout.fontPercent,
                  ),
                  textAlign: TextAlign.center),
              Text('ABCDEFG 가나다라마바사 12345 - 기본',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0 * layout.fontPercent,
                  ),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
