import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:lottie/lottie.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/setting/setting.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = CustomLayoutInfo(MediaQuery.of(context));
    logger.d("Splash view");

    timer = Timer(const Duration(seconds: 2), () async {
      await context.read<SettingCubit>().settingInitial();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEEF0F6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/logo_lottie.json', width: 160.0 * layout.widthPercent, fit: BoxFit.fill, repeat: false),
              const Text(
                "SpendTime",
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1775E5),
                  // height: 20,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}