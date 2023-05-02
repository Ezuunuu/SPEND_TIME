import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class OpeningView extends AbstractScreen {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout(MediaQuery.of(context));

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
                "opening_headline",
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  fontSize: 22,
                ),
              ).tr(),
              SizedBox(height: 16.0 * layout.heightPercent),
              const Text(
                "opening_sub",
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF496D97),
                  fontSize: 14,
                ),
              ).tr(),
              SizedBox(height: 91.0 * layout.heightPercent),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                      onPressed: () => Navigator.push(context, AnimatedPageMove(const WalkThroughView()).fadeIn()),
                      child: const Text(
                        'opening_btn',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                        ),
                      ).tr()),
                ),
              ),
              SizedBox(height: 80.0 * layout.heightPercent),
            ],
          ),
        ),
      ),
    );
  }
}