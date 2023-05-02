import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';

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
    final layout = Layout(MediaQuery.of(context));
    timer = Timer(const Duration(seconds: 2), () async {
      await context.read<SettingCubit>().init();
    });
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CalculateCubit(repository: CalculateRepository())),
          BlocProvider(create: (_) => HabitListCubit(repository: HabitListRepository())),
          BlocProvider(create: (_) => RecordListCubit(repository: RecordListRepository())),
          BlocProvider(create: (_) => StopwatchCubit(repository: StopwatchRepository())),
        ],
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/logo_lottie.json', width: 160.0 * layout.widthPercent, fit: BoxFit.fill, repeat: false),
                  Text(
                    "title",
                    style: Theme.of(context).textTheme.titleLarge
                  ).tr()
                ],
              ),
            ),
          ),
        )
    );
  }
}
