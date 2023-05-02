import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_time/application.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = CustomBlocObserver();
  Paint.enableDithering = true;

  runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ko', 'KR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ko', 'KR'), /// TODO: 추후 Locale('en', 'US')으로 변경
        child: BlocProvider(
          create: (_) => SettingCubit(repository: SettingRepository()..init()),
          child: Application()
        ),
      )
  );
}