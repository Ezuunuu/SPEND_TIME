import 'package:package_info_plus/package_info_plus.dart' as package_info_plus;

class PackageInfo {
  late package_info_plus.PackageInfo packageInfo;

  Future<void> getPackageInfo() async {
    packageInfo = await package_info_plus.PackageInfo.fromPlatform();
  }

  get getAppName => packageInfo.appName;
  get getPackageName => packageInfo.packageName;
  get getVersion => packageInfo.version;
  get getBuildNumber => packageInfo.buildNumber;
}