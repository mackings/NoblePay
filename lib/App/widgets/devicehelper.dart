import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        "deviceid": info.id,
        "devicetype": "Android ${info.model}",
        "deviceosversion": "Android ${info.version.release}",
      };
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        "deviceid": info.identifierForVendor ?? "unknown",
        "devicetype": "iPhone ${info.model}",
        "deviceosversion": "iOS ${info.systemVersion}",
      };
    } else {
      return {
        "deviceid": "unknown",
        "devicetype": "other",
        "deviceosversion": "unknown",
      };
    }
  }
}
