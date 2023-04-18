class TimeUtils {
  getCurrentTime() => DateTime.now();
  getCurrentTimeEpoch() => DateTime.now().millisecondsSinceEpoch;

  int getTimeDifference(int t1, int t2) { return t1 > t2 ? t1 - t2 : t2 - t1; }

}