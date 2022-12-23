import 'dart:async';
///-
import 'package:bloc/bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit({
    required this.stopwatchRepository,
    required this.listRepository,
  }) : super(StopwatchState(
      status: StopwatchStatus.init,
      category: CategoryModel.init(),
      currentTime: Duration.zero,
      habit: 0
  )) {
    logger.d('init');
    initial();
  }

  final StopwatchRepository stopwatchRepository;
  final ListRepository listRepository;

  StreamSubscription<int>? _stopwatchSubscription;

  Future<void> initial() async {
    await stopwatchRepository.init();
    await listRepository.init();
    /// Exist last save
    if (!await stopwatchRepository.isEmpty()) {
      final category = await stopwatchRepository.load();
      emit(state.copyWith(category: category, currentTime: category.habit[category.lastHabitIndex ?? 0].presetTime));
      await start(save: false);
      try {
        if (state.category.habit[state.category.lastHabitIndex ?? 0].stopwatch.last.pause.isEmpty) return;
        if (state.category.habit[state.category.lastHabitIndex ?? 0].stopwatch.last.pause.last.endTime == null &&
            state.category.habit[state.category.lastHabitIndex ?? 0].stopwatch.last.pause.last.startTime != null) {
          emit(state.copyWith(status: StopwatchStatus.pause));
        }
      } catch (e) {
        logger.e('$e');
      }
    }else {
      /// No last save
      final list = await listRepository.load();
      if(list[0].habit.length != 1) {
        list[0].habit.add(HabitModel.init());
      }
      emit(state.copyWith(status: StopwatchStatus.init, category: list[0], habit: list[0].habit.length - 1, currentTime: Duration.zero));
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
    final start = DateTime.now().millisecondsSinceEpoch;
    final habit = state.category.habit[state.habit ?? 0];
    if (save) {
      emit(state.copyWith(status: StopwatchStatus.running));
      CategoryModel c = state.category.copyWith(lastHabitIndex: state.habit)..habit[state.habit ?? 0].stopwatch.add(StopwatchModel(time: TimeModel(startTime: start, currentTime: state.category.habit[state.habit ?? 0].presetTime), pause: List.empty(growable: true)));
      stopwatchRepository.save(category: c);
    }
    final stopwatchStream = await stopwatchRepository.start(
        save: save,
        mode: habit.mode,
        start: habit.stopwatch.last.time.startTime == 0 ? start : habit.stopwatch.last.time.startTime ?? start,
        presetTime: (habit.presetTime ?? Duration.zero).inMilliseconds
    );
    _stopwatchSubscription = stopwatchStream.listen((int time) async {
      final t = time - (habit.stopwatch.last.time.pausedTime ?? 0);
      if (state.status == StopwatchStatus.running) {
        if (t < 0) {
          logger.d('dispose');
          await complete();
        }
        StopwatchModel stopwatch = habit.stopwatch.last;
        stopwatch = stopwatch.copyWith(time: stopwatch.time.copyWith(currentTime: Duration(milliseconds: t < 0 ? 0 : t)));
        /// TODO: 정상 작동하는지 확인 여부 필요
        habit.stopwatch.last = stopwatch;
        emit(state.copyWith(currentTime: Duration(milliseconds: t < 0 ? 0 : t)));
      }
    });
  }

  Future<void> restart() async {
    if (state.status != StopwatchStatus.running &&
        state.status != StopwatchStatus.pause) {
      return;
    }
    final habit = state.category.habit[state.category.lastHabitIndex ?? 0];
    habit.stopwatch.last = StopwatchModel.initWithPresetTime(habit.presetTime ?? Duration.zero);
    emit(state.copyWith(status: StopwatchStatus.init));
    await dispose();
  }

  Future<void> pause() async {
    HabitModel habit = state.category.habit[state.category.lastHabitIndex ?? 0];
    if (state.status == StopwatchStatus.pause) {
      PauseModel? currentPause = habit.stopwatch.last.pause.last.copyWith(endTime: DateTime.now());
      TimeModel? time;
      if (habit.mode == StopwatchMode.timer.index) {
        time = habit.stopwatch.last.time.copyWith(pausedTime: (habit.stopwatch.last.time.pausedTime ?? 0) - currentPause.pauseTime);
      } else {
        time = habit.stopwatch.last.time.copyWith(pausedTime: (habit.stopwatch.last.time.pausedTime ?? 0) + currentPause.pauseTime);
      }
      List<PauseModel>? list = habit.stopwatch.last.pause..removeLast()..add(currentPause);
      StopwatchModel? stopwatch = habit.stopwatch.last.copyWith(pause: list, time: time);
      habit = habit.copyWith(stopwatch: habit.stopwatch..removeLast()..add(stopwatch));
      emit(state.copyWith(status: StopwatchStatus.running));
      await stopwatchRepository.deleteAndSave(category: state.category);
      return;
    } else if (state.status != StopwatchStatus.running) {
      return;
    }
    PauseModel pause = PauseModel(startTime: DateTime.now());
    List<PauseModel>? list = habit.stopwatch.last.pause..add(pause);
    List<StopwatchModel>? sList = habit.stopwatch;
    sList.last = sList.last.copyWith(pause: list);
    habit = habit.copyWith(stopwatch: sList);
    emit(state.copyWith(status: StopwatchStatus.pause));
    await stopwatchRepository.deleteAndSave(category: state.category);
  }

  Future<void> stopwatchModalSetting(Duration presetTime, int alarm) async {
    CategoryModel category = state.category;
    HabitModel habit = category.habit[state.category.lastHabitIndex ?? 0];
    List<StopwatchModel>? sList = habit.stopwatch;
    sList.last = habit.stopwatch.last.copyWith(time: habit.stopwatch.last.time.copyWith(currentTime: presetTime));
    habit = habit.copyWith(
        mode: presetTime == Duration.zero ? StopwatchMode.stopwatch.index : StopwatchMode.timer.index,
        stopwatch: sList,
        presetTime: presetTime,
        sound: alarm
    );
    List<HabitModel> l = category.habit;
    l.last = habit;
    category = category.copyWith(habit: l);
    emit(state.copyWith(category: category, currentTime: presetTime));
  }

  Future<void> setTitle(String title) async {
    List<HabitModel> list = state.category.habit
      ..removeAt(state.habit ?? 0)
      ..insert(state.habit ?? 0, state.category.habit[state.habit ?? 0].copyWith(title: title));
    emit(state.copyWith(category: state.category.copyWith(habit: list)));
  }

  Future<void> complete() async {
    emit(state.copyWith(status: StopwatchStatus.complete));
    await stopwatchRepository.saveDelete();
    /// TODO: category index가 필요해보임
    await listRepository.save(state.category);
    await initial();
    await dispose();
  }

  Future<void> dispose() async {
    await stopwatchRepository.dispose();
    _stopwatchSubscription?.cancel();
    _stopwatchSubscription = null;
  }

  Future<void> setHabit(CategoryModel category, int habit) async {
    emit(state.copyWith(category: category, habit: habit));
  }
}