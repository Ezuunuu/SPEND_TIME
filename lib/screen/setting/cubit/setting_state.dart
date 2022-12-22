part of 'setting_cubit.dart';

enum SettingStatus { none, initial, save, load, error }
enum SecMinMode { second, minute }

class SettingState {
  SettingState({this.status = SettingStatus.none, required this.setting});

  final SettingStatus status;
  final SettingModel setting;

  copyWith({SettingStatus? status, SettingModel? setting}) {
    return SettingState(
      status: status ?? this.status,
      setting: setting ?? this.setting,
    );
  }
}
