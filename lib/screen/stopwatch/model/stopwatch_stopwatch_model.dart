import 'package:hive/hive.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'stopwatch_stopwatch_model.g.dart';

@HiveType(typeId: 3)
class StopwatchModel {
  StopwatchModel({required this.time, required this.pause});

  @HiveField(1)
  final TimeModel time;
  @HiveField(2)
  final List<PauseModel> pause;

  StopwatchModel copyWith({TimeModel? time, List<PauseModel>? pause}) {
    return StopwatchModel(
        time: time ?? this.time,
        pause: pause ?? this.pause
    );
  }

  StopwatchModel.init():
        time = TimeModel(startTime: 0, endTime: 0),
        pause = [];

  StopwatchModel.initWithPresetTime(Duration current):
        time = TimeModel(startTime: 0, endTime: 0, currentTime: current),
        pause = [];
}