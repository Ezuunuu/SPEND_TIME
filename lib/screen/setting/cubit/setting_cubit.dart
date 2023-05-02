import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/screen.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({required this.repository}): super(SettingState());

  final SettingRepository repository;

  Future<void> init() async {
    final setting = await repository.init();
    emit(state.copyWith(setting: setting));
  }
}