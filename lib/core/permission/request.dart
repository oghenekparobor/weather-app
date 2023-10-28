import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_test_foodcourt/core/logger/log.dart';

@lazySingleton
class AppPermission {
  Future<void> requestPermission(List<Permission> permissions) async {
    for (final permission in permissions) {
      final status = await permission.request();

      if (status == PermissionStatus.denied ||
          status == PermissionStatus.permanentlyDenied) {
        AppLogger.log('${permission.toString()} failed');
      }
    }
  }
}
