import 'package:spend_time/screen/setting/setting.dart';

String getSecondStringFromSecond(int sec) {
  int hour = sec ~/ 3600;
  sec -= hour * 3600;

  int min = sec ~/ 60;
  sec -= min * 60;

  return "${hour.toString().padLeft(2,'0')}:${min.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}";
}

String getMinuteStringFromSecond(int sec) {
  int hour = sec ~/ 3600;
  sec -= hour * 3600;

  int min = sec ~/ 60;
  sec -= min * 60;

  return "${hour.toString().padLeft(2,'0')}:${min.toString().padLeft(2,'0')}";
}

String getStringFromDuration(Duration duration, SecMinMode mode) {
  int sec = duration.inSeconds;
  if(mode == SecMinMode.minute) {
    return getMinuteStringFromSecond(sec);
  }else {
    return getSecondStringFromSecond(sec);
  }
}

String msToStringDuration(int ms, SecMinMode mode) {
  int sec = ms ~/ 1000;
  if(mode == SecMinMode.minute) {
    return getMinuteStringFromSecond(sec);
  }else {
    return getSecondStringFromSecond(sec);
  }
}
