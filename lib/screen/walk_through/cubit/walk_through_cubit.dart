import 'package:bloc/bloc.dart';

part 'walk_through_state.dart';

class WalkThroughCubit extends Cubit<WalkThroughState> {
  WalkThroughCubit(): super(WalkThroughState());

  Future<void> setIndex(int index) async {
    emit(state.copyWith(index: index));
  }
}