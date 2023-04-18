class StopwatchModel {
  StopwatchModel({required this.id, this.startTime, this.endTime, this.habitIndex});

  final int id;
  final int? startTime;
  final int? endTime;
  final int? habitIndex;

  StopwatchModel copyWith({int? startTime, int? endTime, int? habitIndex}) {
    return StopwatchModel(
        id: id,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        habitIndex: habitIndex ?? this.habitIndex
    );
  }
}