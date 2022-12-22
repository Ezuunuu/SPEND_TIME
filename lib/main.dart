import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
///--
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
///--
import 'package:spend_time/application.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

Future<void> main() async {
  // async set
  WidgetsFlutterBinding.ensureInitialized();

  // in app image dithering
  Paint.enableDithering = true;

  // db set
  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  Hive.registerAdapter(HabitModelAdapter());
  Hive.registerAdapter(PauseModelAdapter());
  Hive.registerAdapter(StopwatchModelAdapter());
  Hive.registerAdapter(TimeModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(SettingTutorialModelAdapter());

  // portrait up fixed
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // bloc observer post
  Bloc.observer = CustomBlocObserver();

  logger.d("Main start");

  // repository set
  final ListRepository listRepository = ListRepository();
  final StopwatchRepository stopwatchRepository = StopwatchRepository();
  final HabitRepository habitRepository = HabitRepository();

  runApp(
      Application(
        listRepository: listRepository,
        stopwatchRepository: stopwatchRepository,
        habitRepository: habitRepository,
      )
  );
}
