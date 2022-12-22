import 'package:hive/hive.dart';

part 'setting_tutorial_model.g.dart';

@HiveType(typeId: 8)
class SettingTutorialModel {
  SettingTutorialModel({this.alert = true, this.tutorial = true, this.tooltip = 0});

  @HiveField(0)
  final bool alert;
  @HiveField(1)
  final bool tutorial;
  @HiveField(2)
  final int tooltip;

  SettingTutorialModel.defaultSetting()
      : alert = true,
        tutorial = true,
        tooltip = 0;

  SettingTutorialModel copyWith({bool? alert, bool? tutorial, int? tooltip}) {
    return SettingTutorialModel(
      alert: alert ?? this.alert,
      tutorial: tutorial ?? this.tutorial,
      tooltip: tooltip ?? this.tooltip
    );
  }
}

enum ToolTip {
  category,
  habit,
  stopwatch
}