import 'package:flutter/material.dart';
///-
import 'package:lottie/lottie.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/animation/animation.dart';
import 'package:spend_time/screen/walk_through/walk_through.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = CustomLayoutInfo(MediaQuery.of(context));
    logger.d("Opening View");
    return Scaffold(
      backgroundColor: const Color(0xFFEEF0F6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/opening_lottie.json', width: 236.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
              const Text(
                "시간을 담으러 가볼까요?",
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 16.0 * layout.heightPercent,
              ),
              const Text(
                "습관을 시간으로 기록해요",
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF496D97),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 91.0 * layout.heightPercent,
              ),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                      onPressed: () {
                        Navigator.push(context, AnimatedPageMove(const WalkThroughView()).fadeIn());
                      },
                      child: const Text(
                        '지금 담으러 가기',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 80.0 * layout.heightPercent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
