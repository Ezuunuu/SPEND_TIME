part of 'stopwatch_cubit.dart';

enum StopwatchStatus {
  init,
  running,
  pause,
  restart,
  complete,
  setting,
  error,
}

extension StopwatchStatusX on StopwatchStatus {
  bool get isRunning => this == StopwatchStatus.running || this == StopwatchStatus.restart;
}

class StopwatchState {
  StopwatchState(
      {
        this.status = StopwatchStatus.init,
        this.habit,
      });

  StopwatchStatus? status;
  HabitModel? habit;

  StopwatchState copyWith(
      {
        StopwatchStatus? status,
        HabitModel? habit,
      }) {
    return StopwatchState(
      status: status ?? this.status,
      habit: habit ?? this.habit,
    );
  }
}