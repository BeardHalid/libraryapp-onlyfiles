import 'package:permission_handler/permission_handler.dart';

class Permissions {
  void galleryPermission() async {
    var permission = await Permission.photos.request();
    if (permission.isGranted) {
    } else if (permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
