import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  dynamic info;

  Future<void> getDeviceInfo() async {
    if(Platform.isAndroid) {
      info = await deviceInfo.androidInfo;
      // AndroidDeviceInfo
    }else if(Platform.isIOS) {
      info = await deviceInfo.iosInfo;
      // IosDeviceInfo
    }
  }

  get getVersion => info.version;


}