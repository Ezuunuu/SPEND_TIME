import 'package:spend_time/config/config.dart';
import 'package:spend_time/database/database.dart';

class SettingRepository {
  final SettingProvider _provider = SettingProvider();
  SettingModel? _setting;

  Future<SettingModel> init() async {
    try {
      logger.d('init');
      _provider.init();
      _setting ??= await _provider.load();
      return _setting ?? SettingModel.init();
    }catch(e) {
      return SettingModel.init();
    }
  }

  Future<SettingModel> switchDarkMode() async {
    try {
      final darkMode = _setting?.darkMode;
      _setting?.copyWith(opening: !darkMode!);
      await _provider.save(_setting!);
    }catch(e) {
      _setting = SettingModel();
      await _provider.save(_setting!);
    }
    return _setting!;
  }

  Future<SettingModel> switchOpening() async {
    try {
      final opening = _setting?.opening;
      _setting?.copyWith(opening: !opening!);
      await _provider.save(_setting!);
    }catch(e) {
      _setting = SettingModel();
      await _provider.save(_setting!);
    }
    return _setting!;
  }

  Future<SettingModel> switchTimeMode() async {
    try {
      final timeMode = _setting?.timeMode;
      _setting?.copyWith(timeMode: timeMode == TimeMode.minute ? TimeMode.second : TimeMode.minute);
      await _provider.save(_setting!);
    }catch(e) {
      _setting = SettingModel();
      await _provider.save(_setting!);
    }
    return _setting!;
  }
}