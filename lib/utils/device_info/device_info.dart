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

  get getVersion async {
    if(Platform.isAndroid) {
      return info.version;
    }else if(Platform.isIOS) {
      return info.systemVersion;
    }
    return 'Unknown';
  }

  get getModel {
    if(Platform.isAndroid) {
      return info.model;
    }else if (Platform.isIOS) {
      return info.utsname.machine;
    }
    return 'Unknown';
  }
}