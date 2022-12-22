import 'package:flutter/material.dart';

class DevelopExampleView extends StatelessWidget {
  const DevelopExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Text('ABCDEF 가나다라마바사 12345 - 800',
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center),
            Text('ABCDEF 가나다라마바사 12345 - 700',
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center),
            Text('ABCDEF 가나다라마바사 12345 - 500',
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center),
            Text('ABCDEF 가나다라마바사 12345 - 400',
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center),
            Text('ABCDEF 가나다라마바사 12345 - 기본',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
