part of 'setting_cubit.dart';


class SettingState {
  SettingState({this.setting});

  final SettingModel? setting;

  SettingState copyWith({SettingModel? setting}) {
    return SettingState(
      setting: setting ?? this.setting
    );
  }
}