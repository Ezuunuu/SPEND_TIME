import 'package:hive/hive.dart';
///-
import 'package:spend_time/utils/utils.dart';
import 'package:spend_time/screen/stopwatch/model/stopwatch_model.dart';

part 'stopwatch_habit_model.g.dart';

@HiveType(typeId: 2)
class HabitModel {
  HabitModel({this.mode = 0, required this.title, this.icon, this.sound, this.presetTime, required this.stopwatch});

  @HiveField(0)
  final int mode;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? icon;
  @HiveField(3)
  final int? sound;
  @HiveField(4)
  final Duration? presetTime;
  @HiveField(5)
  final List<StopwatchModel> stopwatch;

  HabitModel copyWith(
      {
        int? mode,
        String? title,
        String? icon,
        int? sound,
        Duration? presetTime,
        List<StopwatchModel>? stopwatch
      }) {
    return HabitModel(
        mode: mode ?? this.mode,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        sound: sound ?? this.sound,
        presetTime: presetTime ?? this.presetTime,
        stopwatch: stopwatch ?? this.stopwatch
    );
  }

  HabitModel.init():
        mode = 0,
        title = '제목 없음',
        icon = 'assets/images/stopwatch_sticker_default_icon.svg',
        sound = 0,
        presetTime = Duration.zero,
        stopwatch = [StopwatchModel.init()];

  get todayUseTime {
    int useTime = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareDay(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
      }else {
        break;
      }
      return useTime;
    }
  }

  get todayAverageTime {
    int useTime = 0;
    int count = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareDay(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
        count++;
      }else {
        break;
      }
      return useTime / count;
    }
  }

  get weekUseTime {
    int useTime = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareWeek(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
      }else {
        break;
      }
      return useTime;
    }
  }

  get weekAverageTime {
    int useTime = 0;
    int count = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareWeek(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
        count++;
      }else {
        break;
      }
      return useTime / count;
    }
  }

  get monthUseTime {
    int useTime = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareMonth(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
      }else {
        break;
      }
      return useTime;
    }
  }

  get monthAverageTime {
    int useTime = 0;
    int count = 0;
    for(var i in stopwatch) {
      final time = i.time;
      if(compareMonth(ms: time.startTime ?? 0)) {
        useTime += time.useTime;
        count++;
      }else {
        break;
      }
      return useTime / count;
    }
  }

  get allUseTime {
    int useTime = 0;
    for(var i in stopwatch) {
      final time = i.time;
      useTime += time.useTime;
    }
    return useTime;
  }

  get continuousCount {
    int count = 0;
    int standardTime = 0;
    for(var i in stopwatch) {
      final time = i.time.startTime;
      if(compareContinuous(t1: time ?? 0, t2: standardTime) || time == 0) {
        count++;
      }else {
        break;
      }
      return count;
    }
  }

  bool longestTime(TimeModel t) {
    for(var i in stopwatch) {
      final time = i.time.useTime;
      if(compareUseTime(t: t.useTime, compare: time)) {
        return true;
      }
    }
    return false;
  }
}