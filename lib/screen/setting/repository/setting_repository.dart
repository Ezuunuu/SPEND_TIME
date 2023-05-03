import 'package:spend_time/config/config.dart';
import 'package:spend_time/database/database.dart';

class SettingRepository {
  final SettingProvider _provider = SettingProvider();
  SettingModel? setting;

  Future<SettingModel> init() async {
    try {
      logger.d('init');
      _provider.init();
      setting ??= await _provider.load();
      return setting ?? SettingModel.init();
    }catch(e) {
      return SettingModel.init();
    }
  }

  Future<SettingModel> switchDarkMode() async {
    try {
      final darkMode = setting?.darkMode;
      setting?.copyWith(opening: !darkMode!);
      await _provider.save(setting!);
    }catch(e) {
      setting = SettingModel();
      await _provider.save(setting!);
    }
    return setting!;
  }

  Future<SettingModel> switchOpening() async {
    try {
      final opening = setting?.opening;
      setting?.copyWith(opening: !opening!);
      await _provider.save(setting!);
    }catch(e) {
      setting = SettingModel();
      await _provider.save(setting!);
    }
    return setting!;
  }

  Future<SettingModel> switchTimeMode() async {
    try {
      final timeMode = setting?.timeMode;
      setting?.copyWith(timeMode: timeMode == TimeMode.minute ? TimeMode.second : TimeMode.minute);
      await _provider.save(setting!);
    }catch(e) {
      setting = SettingModel();
      await _provider.save(setting!);
    }
    return setting!;
  }
}