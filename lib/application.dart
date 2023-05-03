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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WalkThroughCubit()),
        BlocProvider(create: (_) => CalculateCubit(repository: CalculateRepository())),
        BlocProvider(create: (_) => HabitListCubit(repository: HabitListRepository())),
        BlocProvider(create: (_) => RecordListCubit(repository: RecordListRepository())),
        BlocProvider(create: (_) => StopwatchCubit(repository: StopwatchRepository())),
      ],
      child: MaterialApp(
        theme: lightTheme,
        navigatorKey: _navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: (_) => AnimatedPageMove(const SplashView()).fadeIn(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: BlocListener<SettingCubit, SettingState>(
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
            ),
          );
        },
      ),
    );
  }
}
