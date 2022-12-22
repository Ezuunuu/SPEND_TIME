import 'package:hive/hive.dart';
import 'package:spend_time/config/config.dart';

part 'stopwatch_pause_model.g.dart';

@HiveType(typeId: 5)
class PauseModel {
  PauseModel({this.startTime, this.endTime});

  @HiveField(0)
  final DateTime? startTime;
  @HiveField(1)
  final DateTime? endTime;

  int get pauseTime => (endTime!.millisecondsSinceEpoch) - (startTime!.millisecondsSinceEpoch);

  List<PauseModel> parsingData(String data) {
    List<PauseModel> pause = [];
    final dataList = data.split('|');
    for(int i = 0; i < dataList.length - 1; i++) {
      final time = dataList[i].split('-');
      DateTime? start;
      DateTime? end;
      try {
        start = DateTime.fromMillisecondsSinceEpoch(int.parse(time[0]));
      }catch(e) {
        logger.e(e);
      }
      try {
        if(time[1] != 'null') {
          end = DateTime.fromMillisecondsSinceEpoch(int.parse(time[1]));
        }else {
          end = null;
        }
      }catch(e) {
        logger.e(e);
      }
      final p = PauseModel(startTime: start, endTime: end);
      pause.add(p);
    }
    return pause;
  }

  PauseModel copyWith(
      {
        DateTime? startTime,
        DateTime? endTime
      }) {
    return PauseModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime
    );
  }
}