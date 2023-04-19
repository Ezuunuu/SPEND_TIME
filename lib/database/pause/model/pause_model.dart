class PauseModel {
  PauseModel({required this.id, this.startTime, this.endTime, this.stopwatchIndex});

  final int id;
  final int? startTime;
  final int? endTime;
  final int? stopwatchIndex;

  PauseModel copyWith({int? startTime, int? endTime}) {
    return PauseModel(
        id: id,
        startTime: startTime ?? startTime,
        endTime: endTime ?? endTime,
        stopwatchIndex: stopwatchIndex
    );
  }
}