enum HabitMode {
  stopwatch,
  timer
}

class HabitModel {
  HabitModel({required this.id, this.title, this.mode = HabitMode.stopwatch, this.icon, this.alarm, this.presetTime, this.categoryIndex});

  final int id;
  final String? title;
  final HabitMode mode;
  final String? icon;
  final String? alarm;
  final int? presetTime;
  final int? categoryIndex;

  HabitModel copyWith({String? title, HabitMode? mode, String? icon, String? alarm, int? presetTime, int? categoryIndex}) {
    return HabitModel(
        id: id,
        title: title ?? this.title,
        mode: mode ?? this.mode,
        icon: icon ?? this.icon,
        alarm: alarm ?? this.alarm,
        presetTime: presetTime ?? this.presetTime,
        categoryIndex: categoryIndex ?? this.categoryIndex
    );
  }
}