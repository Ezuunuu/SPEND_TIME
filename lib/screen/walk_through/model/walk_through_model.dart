import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_time/config/config.dart';

class WalkThroughModel extends StatelessWidget {
  const WalkThroughModel(
      {
        Key? key,
        required this.headline,
        required this.sub,
        required this.lottie,
        required this.layout
      }) : super(key: key);

  final String headline;
  final String sub;

  final String lottie;

  final Layout layout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "headline",
          style: TextStyle(
            fontFamily: 'SUIT',
            fontWeight: FontWeight.w800,
            color: Color(0xFF000000),
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.0 * layout.heightPercent),
        const Text(
          "sub",
          style: TextStyle(
            fontFamily: 'SUIT',
            fontWeight: FontWeight.w500,
            color: Color(0xFF496D97),
            fontSize: 14,
          ),
        ),
        Lottie.asset(lottie, width: 226.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
      ],
    );
  }
}
