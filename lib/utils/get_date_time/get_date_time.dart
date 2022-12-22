import 'package:intl/intl.dart';
import 'package:spend_time/config/config.dart';

dynamic getCurrentTime({DateFormat? format}) {
  var now = DateTime.now();
  if(format == null) {
    return now.millisecondsSinceEpoch;
  }else {
    return format.format(now);
  }
}

DateTime getCurrentDateTime({DateFormat? format}) {
  final now = DateTime.now();
  return now;
}

bool compareDay({required int ms}) {
  final input = DateTime.fromMicrosecondsSinceEpoch(ms);
  final now = DateTime.now();
  if(input.year == now.year && input.month == now.month && input.day == now.day) {
    return true;
  }
  return false;
}

bool compareWeek({required int ms}) {
  final now = DateTime.now();

  var firstTime = DateTime(now.year, now.month, now.day - (now.weekday - 1)).millisecondsSinceEpoch;
  var lastTime = DateTime(now.year, now.month, now.day + (7 - now.weekday)).millisecondsSinceEpoch;

  if(ms >= firstTime && ms <= lastTime) {
    return true;
  }
  return false;
}

bool compareMonth({required int ms}) {
  final now = DateTime.now();

  var firstTime = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
  var lastTime = DateTime(now.year, now.month + 1, 0).millisecondsSinceEpoch;

  if(ms >= firstTime && ms <= lastTime) {
    return true;
  }
  return false;
}

int getBetweenTime({required int t1, required int t2}) {
  if(t1 > t2) {
    return t1 - t2;
  }else {
    return t2 - t1;
  }
}

bool compareContinuous({required int t1, required int t2}) {
  if(getBetweenTime(t1: t1, t2: t2) == 86400000) {
    return true;
  }
  return false;
}

bool compareUseTime({required int t, required int compare}) {
  if(t > compare) {
    return true;
  }
  return false;
}

String msToString(DateFormat format, int ms) {
  logger.d("ms: $ms");
  return format.format(DateTime.fromMillisecondsSinceEpoch(ms));
}

DateTime? stringToDateTime(String time) {
  if(time.contains('년') && time.contains('월') && time.contains('일')) {
    final splitted = time.split(' ');
    String yearStr = splitted[0];
    int year = int.parse(yearStr.substring(0, yearStr.length - 1)) + 2000;

    String monthStr = splitted[1];
    int month = int.parse(monthStr.substring(0, monthStr.length - 1));

    String dayStr = splitted[2];
    int day = int.parse(dayStr.substring(0, dayStr.length - 1));

    DateTime dateTime = DateTime.parse(year.toString() + month.toString() + day.toString());

    return dateTime;
  }
  logger.d('stringToDateTime Error');
  return null;
}

DateFormat defaultDateFormat() {
  return DateFormat('yy년 MM월 dd일 E요일', 'ko_KR');
}