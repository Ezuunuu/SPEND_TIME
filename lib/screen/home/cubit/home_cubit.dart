import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(status: HomeStatus.init));

  Future<void> changeIndex(int index) async {
    emit(state.copyWith(index: index));
  }

  Future<void> setTutorial(bool value) async {
    emit(state.copyWith(tutorial: value));
  }
}