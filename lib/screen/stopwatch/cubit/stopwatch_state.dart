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
        required this.category,
        this.habit,
        required this.currentTime
      });

  StopwatchStatus? status;
  CategoryModel category;
  int? habit;
  Duration currentTime;

  StopwatchState copyWith(
      {
        StopwatchStatus? status,
        CategoryModel? category,
        int? habit,
        Duration? currentTime
      }) {
    return StopwatchState(
      status: status ?? this.status,
      category: category ?? this.category,
      habit: habit ?? this.habit,
      currentTime: currentTime ?? this.currentTime
    );
  }
}