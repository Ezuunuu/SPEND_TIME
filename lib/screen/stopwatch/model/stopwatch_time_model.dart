import 'package:hive/hive.dart';

part 'stopwatch_time_model.g.dart';

@HiveType(typeId: 4)
class TimeModel {
  TimeModel({this.startTime, this.endTime, this.pausedTime, this.currentTime});

  @HiveField(0)
  final int? startTime;
  @HiveField(1)
  final int? endTime;
  @HiveField(2)
  final int? pausedTime;
  @HiveField(3)
  final Duration? currentTime;

  int get useTime => ((endTime ?? 0) - (startTime ?? 0)) - (pausedTime ?? 0);

  TimeModel copyWith(
      {
        int? startTime,
        int? endTime,
        int? pausedTime,
        Duration? currentTime
      }) {
    return TimeModel(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        pausedTime: pausedTime ?? this.pausedTime,
        currentTime: currentTime ?? this.currentTime,
    );
  }
}