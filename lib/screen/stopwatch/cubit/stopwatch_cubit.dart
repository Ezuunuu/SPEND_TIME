import 'package:bloc/bloc.dart';
import 'package:spend_time/screen/screen.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit({required this.repository}): super(StopwatchState());

  final StopwatchRepository repository;

}