import 'package:hive/hive.dart';
///-
import 'package:spend_time/screen/setting/setting.dart';

export 'setting_tutorial_model.dart';

part 'setting_model.g.dart';

@HiveType(typeId: 1)
class SettingModel {
  SettingModel({this.darkMode = false, this.visibleOpening = true, this.secMinMode = 0, this.tutorial});

  @HiveField(0)
  final bool darkMode;
  @HiveField(1)
  final bool visibleOpening;
  @HiveField(2)
  final int secMinMode;
  @HiveField(3)
  final SettingTutorialModel? tutorial;

  SettingModel.defaultSetting()
      : darkMode = false,
        visibleOpening = true,
        secMinMode = SecMinMode.second.index,
        tutorial = SettingTutorialModel();

  SettingModel copyWith({bool? darkMode, bool? visibleOpening, int? secMinMode, SettingTutorialModel? tutorial}) {
    return SettingModel(
      darkMode: darkMode ?? this.darkMode,
      visibleOpening: visibleOpening ?? this.visibleOpening,
      secMinMode: secMinMode ?? this.secMinMode,
      tutorial: tutorial ?? this.tutorial,
    );
}
}
