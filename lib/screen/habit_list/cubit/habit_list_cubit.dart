import 'package:bloc/bloc.dart';
import 'package:spend_time/screen/screen.dart';

part 'habit_list_state.dart';

class HabitListCubit extends Cubit<HabitListState> {
  HabitListCubit({required this.repository}): super(HabitListState());

  final HabitListRepository repository;
}