import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/home/home.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/animation/animation.dart';
import 'package:spend_time/screen/splash/splash.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/screen/opening/opening.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

class Application extends StatelessWidget {
  Application(
      {
        Key? key,
        required this.stopwatchRepository,
        required this.listRepository,
      }) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  final ListRepository listRepository;
  final StopwatchRepository stopwatchRepository;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus!.unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()),
          BlocProvider(create: (_) => ListCubit(listRepository: listRepository)),
          BlocProvider(create: (_) => StopwatchCubit(stopwatchRepository: stopwatchRepository, listRepository: listRepository)),
          BlocProvider(create: (_) => SettingCubit()),
        ],
        child: MaterialApp(
            navigatorKey: _navigatorKey,
            onGenerateRoute: (_) {
              return MaterialPageRoute(builder: (context) => const SplashView());
            },
            builder: (context, child) {
              return BlocListener<SettingCubit, SettingState>(
                listenWhen: (previous, current) => previous.status == SettingStatus.load && current.status == SettingStatus.initial,
                child: child,
                listener: (context, state) async {
                  if(state.setting.visibleOpening) {
                    logger.d("Start first time");
                    await _navigator!.pushReplacement(AnimatedPageMove(const OpeningView()).fadeIn());
                  } else {
                    logger.d("Start main");
                    await _navigator!.pushReplacement(AnimatedPageMove(const HomeView()).fadeIn());
                  }
                },
              );
            }),
      ),
    );
  }
}
