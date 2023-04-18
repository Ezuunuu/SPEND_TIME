enum TimeMode {
  second,
  minute,
}

class SettingModel {
  SettingModel({this.darkMode, this.opening, this.timeMode});

  final bool? darkMode;
  final bool? opening;
  final TimeMode? timeMode;

  SettingModel copyWith({bool? darkMode, bool? opening, TimeMode? timeMode}) {
    return SettingModel(
      darkMode: darkMode ?? this.darkMode,
      opening: opening ?? this.opening,
      timeMode: timeMode ?? this.timeMode
    );
  }

}