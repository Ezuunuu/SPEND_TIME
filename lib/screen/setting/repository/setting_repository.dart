import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/setting/setting.dart';

enum Setting { darkMode, visibleOpening, }

class SettingRepository {
  late DatabaseRepository _databaseRepository;

  late SettingModel setting;

  Future<SettingModel> settingInitial() async {
    _databaseRepository = DatabaseRepository();
    await _databaseRepository.init(name: SETTING_KEY);
    setting = await _databaseRepository.get(name: SETTING_KEY, defaultValue: SettingModel.defaultSetting());
    return setting;
  }

  Future<SettingModel> switchBoolValue(Setting num, bool value) async {
    switch (num) {
      case Setting.darkMode:
        setting = setting.copyWith(darkMode: value);
        break;
      case Setting.visibleOpening:
        setting = setting.copyWith(visibleOpening: value);
        break;
    }
    await _databaseRepository.put(key: SETTING_KEY, value: setting);
    return setting;
  }

  Future<SettingModel> setSecMinMode(SecMinMode mode) async {
    setting = setting.copyWith(secMinMode: mode.index);
    await _databaseRepository.put(key: SETTING_KEY, value: setting);
    return setting;
  }

  Future<SettingModel> disableAlert() async {
    setting = setting.copyWith(tutorial: setting.tutorial?.copyWith(alert: false));
    await _databaseRepository.put(key: SETTING_KEY, value: setting);
    return setting;
  }

  Future<SettingModel> setTooltip(int index) async {
    setting = setting.copyWith(tutorial: setting.tutorial?.copyWith(tooltip: index));
    await _databaseRepository.put(key: SETTING_KEY, value: setting);
    return setting;
  }

  // ignore: non_constant_identifier_names
  String SETTING_KEY = 'SPEND_TIME_SETTING';
}
