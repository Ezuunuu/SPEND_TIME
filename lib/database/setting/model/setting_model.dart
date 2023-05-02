enum TimeMode {
  second,
  minute,
}

class SettingModel {
  SettingModel({this.darkMode, this.opening, this.timeMode = TimeMode.second});

  final bool? darkMode;
  final bool? opening;
  final TimeMode timeMode;

  SettingModel copyWith({bool? darkMode, bool? opening, TimeMode? timeMode}) {
    return SettingModel(
      darkMode: darkMode ?? this.darkMode,
      opening: opening ?? this.opening,
      timeMode: timeMode ?? this.timeMode
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode,
      'opening': opening,
      'timeMode': timeMode.index
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      darkMode: map['darkMode'],
      opening: map['opening'],
      timeMode: TimeMode.values[map['timeMode']]
    );
  }

  factory SettingModel.init() {
    return SettingModel(
      darkMode: false,
      opening: true,
      timeMode: TimeMode.second,
    );
  }

}