import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        "device_id": info.id,
        "device_type": "Android ${info.model}",
        "os_version": "Android ${info.version.release}",
      };
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        "device_id": info.identifierForVendor ?? "unknown",
        "device_type": "iPhone ${info.model}",
        "os_version": "iOS ${info.systemVersion}",
      };
    } else {
      return {
        "device_id": "unknown",
        "device_type": "other",
        "os_version": "unknown",
      };
    }
  }
}
