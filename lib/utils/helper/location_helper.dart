import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'dialog_helper.dart';

class LocationHelper {
  LocationHelper._();

  static Future<bool> requestGps() async {
    bool serviceEnabled = await loc.Location.instance.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await loc.Location.instance.requestService();
    }
    if (!serviceEnabled) {
      DialogHelper.showSnacbar(
        message: "GPS tidak aktif. Segera hidupkan GPS Anda untuk melanjutkan",
      );

      return false;
    }
    return true;
  }

  static Future<bool> requestPermissionLocation() async {
    final bool isAccessGps = await requestGps();
    if (!isAccessGps) return false;
    bool isAccessLocation = false;
    loc.PermissionStatus? permission;
    await Permission.location.request().isGranted.then((isTrue) async {
      permission = await loc.Location.instance.hasPermission();
      if (permission == loc.PermissionStatus.granted) {
        isAccessLocation = true;
      } else if (permission == loc.PermissionStatus.denied || permission == loc.PermissionStatus.deniedForever) {
        DialogHelper.showSnacbar(
          message: "Izin lokasi tidak aktif. Segera hidupkan izin lokasi Anda untuk melanjutkan",
        );
      }
    });
    return isAccessLocation;
  }

  static Future<loc.LocationData?> getCurrentLocation() async {
    loc.LocationData? result;
    final location = await loc.Location.instance.getLocation();
    if (location.isMock == true) {
      DialogHelper.showSnacbar(
        message: "Anda terdeteksi menggunakan lokasi palsu!",
      );
    } else {
      result = location;
    }
    return result;
  }
}