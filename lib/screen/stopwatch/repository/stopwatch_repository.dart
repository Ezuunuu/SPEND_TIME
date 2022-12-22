import 'dart:async';
///-
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

class StopwatchRepository {
  StreamController<int> _stopwatchStreamController = StreamController.broadcast();
  Timer? timer;

  late DatabaseRepository _databaseRepository;

  Future<void> init() async {
    _databaseRepository = DatabaseRepository();
    await _databaseRepository.init(name: STOPWATCH_KEY);
  }

  Future<Stream<int>> start({bool save = true, required int mode, required int start, int presetTime = 0}) async {
    _stopwatchStreamController = StreamController.broadcast();
    if(mode == StopwatchMode.stopwatch.index) {
      /// STOPWATCH
      timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        final time = DateTime.now().millisecondsSinceEpoch - start;
        _stopwatchStreamController.add(time);
      });
    }else if(mode == StopwatchMode.timer.index) {
      /// TIMER
      final time = (start + presetTime) + (save ? 1000 : 0);
      timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        final result = time - DateTime.now().millisecondsSinceEpoch;
        _stopwatchStreamController.add(result);
      });
    }
    return _stopwatchStreamController.stream;
  }

  Future<bool> isEmpty() async {
    return await _databaseRepository.isEmpty();
  }

  Future<void> save({required HabitModel habit}) async {
    await _databaseRepository.put(key: STOPWATCH_KEY, value: habit);
  }

  Future<HabitModel> load() async {
    return await _databaseRepository.get(name: STOPWATCH_KEY, defaultValue: HabitModel.init());
  }

  Future<void> saveDelete() async {
    await _databaseRepository.deleteAll();
  }

  Future<void> deleteAndSave({required HabitModel habit}) async {
    await saveDelete();
    await save(habit: habit);
  }

  Future<void> dispose() async {
    timer?.cancel();
    timer = null;
    await _stopwatchStreamController.close();
  }
}

// ignore: non_constant_identifier_names
String STOPWATCH_KEY = 'SPEND_TIME _STOPWATCH';