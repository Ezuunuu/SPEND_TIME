import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_time/database/database.dart';

class SettingProvider {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(SettingModel setting) async {
    try {
      final map = setting.toMap();
      _prefs.setString(_key, json.encode(map));
    }catch(e) {
      throw InsertFailed();
    }
  }

  Future<SettingModel> load() async {
    try {
      final setting = SettingModel.fromMap(json.decode(_prefs.getString(_key)!));
      return setting;
    }catch(e) {
      throw SelectFailed();
    }
  }

  final _key = 'SPEND_TIME_SETTING_KEY';
}