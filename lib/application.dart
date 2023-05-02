import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: (_) => AnimatedPageMove(const SplashView()).fadeIn(),
      builder: (context, child) {
        return BlocListener<SettingCubit, SettingState>(
          listenWhen: (previous, current) => previous.setting != current.setting,
          listener: (context, state) async {
            if(state.setting?.opening ?? true) {
              await _navigator!.pushReplacement(AnimatedPageMove(const OpeningView()).fadeIn());
            }else {
              logger.d('${state.setting?.opening}');
              await _navigator!.pushReplacement(AnimatedPageMove(const HomeView()).fadeIn());
            }
          },
          child: child,
        );
      },
    );
  }
}
