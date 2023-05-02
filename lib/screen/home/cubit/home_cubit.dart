import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  Future<void> changeIndex({required int index}) async {
    emit(state.copyWith(index: index));
  }

}