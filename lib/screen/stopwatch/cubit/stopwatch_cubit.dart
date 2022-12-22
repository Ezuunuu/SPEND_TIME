import 'dart:async';
///-
import 'package:bloc/bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit({
    required this.stopwatchRepository,
    required this.habitRepository,
  }) : super(StopwatchState(
      status: StopwatchStatus.init,
      habit: HabitModel.init()
  )) {
    checkSave();
  }

  final StopwatchRepository stopwatchRepository;
  final HabitRepository habitRepository;

  StreamSubscription<int>? _stopwatchSubscription;

  Future<void> initial() async {
    emit(state.copyWith(status: StopwatchStatus.init));
  }

  Future<void> checkSave() async {
    await stopwatchRepository.init();
    if (!await stopwatchRepository.isEmpty()) {
      /// Exist last save
      emit(state.copyWith(habit: await stopwatchRepository.load()));
      await start(save: false);
      try {
        if (state.habit!.stopwatch.last.pause.isEmpty) return;
        if (state.habit!.stopwatch.last.pause.last.endTime == null &&
            state.habit!.stopwatch.last.pause.last.startTime != null) {
          emit(state.copyWith(status: StopwatchStatus.pause));
        }
      } catch (e) {
        logger.e('$e');
      }
    }
  }

  Future<void> start({bool save = true}) async {
    if (state.status == StopwatchStatus.running ||
        state.status == StopwatchStatus.pause) {
      await complete();
      return;
    }
    _stopwatchSubscription?.cancel();
    _stopwatchSubscription = null;
    final start = DateTime
        .now()
        .millisecondsSinceEpoch;
    if (save) {
      emit(state.copyWith(status: StopwatchStatus.running));
      state.habit?.stopwatch.last = state.habit!.stopwatch.last.copyWith(
          time: TimeModel(startTime: start,
              currentTime: state.habit!.stopwatch.last.time.currentTime));
      stopwatchRepository.save(habit: state.habit ?? HabitModel.init());
    }
    final stopwatchStream = await stopwatchRepository.start(
        save: save,
        mode: state.habit?.mode ?? StopwatchMode.stopwatch.index,
        start: state.habit?.stopwatch.last.time.startTime == 0 ? start : state
            .habit?.stopwatch.last.time.startTime ?? start,
        presetTime: (state.habit?.presetTime ?? Duration.zero).inMilliseconds
    );
    _stopwatchSubscription = stopwatchStream.listen((int time) async {
      final t = time - (state.habit?.stopwatch.last.time.pausedTime ?? 0);
      if (state.status == StopwatchStatus.running) {
        if (t < 0) {
          logger.d('dispose');
          await complete();
        }
        StopwatchModel? stopwatch = state.habit?.stopwatch.last;
        stopwatch = stopwatch?.copyWith(time: stopwatch.time.copyWith(
            currentTime: Duration(milliseconds: t < 0 ? 0 : t)));
        state.habit?.stopwatch.last = stopwatch!;
        emit(state.copyWith(
            habit: state.habit?.copyWith(stopwatch: state.habit?.stopwatch)));
      }
    });
  }

  Future<void> restart() async {
    if (state.status != StopwatchStatus.running &&
        state.status != StopwatchStatus.pause) {
      return;
    }
    final habit = state.habit;
    if (state.habit?.mode == StopwatchMode.stopwatch.index) {
      habit?.stopwatch.last = StopwatchModel.init();
      emit(state.copyWith(status: StopwatchStatus.init, habit: habit));
    } else if (state.habit?.mode == StopwatchMode.timer.index) {
      habit?.stopwatch.last = habit.stopwatch.last.copyWith(
          pause: List.empty(growable: true),
          time: TimeModel(currentTime: state.habit?.presetTime,
              startTime: 0,
              endTime: 0,
              pausedTime: 0));
      emit(state.copyWith(status: StopwatchStatus.init, habit: habit));
    }
    await dispose();
  }

  Future<void> pause() async {
    if (state.status == StopwatchStatus.pause) {
      PauseModel? currentPause = state.habit?.stopwatch.last.pause.last
          .copyWith(endTime: DateTime.now());
      TimeModel? time;
      if (state.habit?.mode == StopwatchMode.timer.index) {
        time = state.habit?.stopwatch.last.time.copyWith(
            pausedTime: (state.habit?.stopwatch.last.time.pausedTime ?? 0) -
                currentPause!.pauseTime);
      } else {
        time = state.habit?.stopwatch.last.time.copyWith(
            pausedTime: (state.habit?.stopwatch.last.time.pausedTime ?? 0) +
                currentPause!.pauseTime);
      }
      List<PauseModel>? list = state.habit?.stopwatch.last.pause
        ?..removeLast()
        ..add(currentPause!);
      StopwatchModel? stopwatch = state.habit?.stopwatch.last.copyWith(
          pause: list, time: time);
      emit(state.copyWith(status: StopwatchStatus.running,
          habit: state.habit?.copyWith(stopwatch: state.habit?.stopwatch
            ?..removeLast()
            ..add(stopwatch!))));
      await stopwatchRepository.deleteAndSave(habit: state.habit!);
      return;
    } else if (state.status != StopwatchStatus.running) {
      return;
    }
    PauseModel pause = PauseModel(startTime: DateTime.now());
    List<PauseModel>? list = state.habit?.stopwatch.last.pause?..add(pause);
    List<StopwatchModel>? sList = state.habit?.stopwatch;
    sList?.last = sList.last.copyWith(pause: list);
    emit(state.copyWith(status: StopwatchStatus.pause,
        habit: state.habit?.copyWith(stopwatch: sList)));
    await stopwatchRepository.deleteAndSave(habit: state.habit!);
  }

  Future<void> stopwatchModalSetting(Duration presetTime, int alarm) async {
    List<StopwatchModel>? sList = state.habit?.stopwatch;
    sList?.last = state.habit!.stopwatch.last.copyWith(
        time: state.habit?.stopwatch.last.time.copyWith(
            currentTime: presetTime));
    emit(state.copyWith(
        status: StopwatchStatus.setting,
        habit: state.habit?.copyWith(mode: presetTime.inMilliseconds == 0
            ? StopwatchMode.stopwatch.index
            : StopwatchMode.timer.index,
            stopwatch: sList,
            presetTime: presetTime,
            sound: alarm))
    );
    await initial();
  }

  Future<void> setTitle(String title) async {
    emit(state.copyWith(habit: state.habit?.copyWith(title: title)));
  }

  Future<void> complete() async {
    emit(state.copyWith(
        status: StopwatchStatus.complete, habit: HabitModel.init()));
    await stopwatchRepository.saveDelete();
    await initial();
    await dispose();
  }

  Future<void> dispose() async {
    await stopwatchRepository.dispose();
    _stopwatchSubscription?.cancel();
    _stopwatchSubscription = null;
  }

  Future<void> setHabit(CategoryModel category, int habit) async {
    emit(state.copyWith(habit: category.habit[habit]));
  }
}