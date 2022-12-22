///-
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/screen/setting/setting.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingState(setting: SettingModel.defaultSetting()));

  final SettingRepository _settingRepository = SettingRepository();

  Future<void> settingInitial() async {
    emit(state.copyWith(status: SettingStatus.load));
    var setting = await _settingRepository.settingInitial();
    emit(state.copyWith(status: SettingStatus.initial, setting: setting));
  }

  Future<void> switchDarkMode() async {
    SettingModel setting = await _settingRepository.switchBoolValue(Setting.darkMode, !state.setting.darkMode);
    emit(state.copyWith(setting: setting));
  }

  Future<void> switchVisibleOpening() async {
    SettingModel setting = await _settingRepository.switchBoolValue(Setting.visibleOpening, !state.setting.visibleOpening);
    emit(state.copyWith(setting: setting));
  }

  Future<void> switchSecMinMode(SecMinMode mode) async {
    SettingModel setting = await _settingRepository.setSecMinMode(mode);
    emit(state.copyWith(setting: setting));
  }

  Future<void> disableAlert() async {
    SettingModel setting = await _settingRepository.disableAlert();
    emit(state.copyWith(setting: setting));
  }

  Future<void> setTooltip(int index) async {
    SettingModel setting = await _settingRepository.setTooltip(index);
    emit(state.copyWith(setting: setting));
  }
}
