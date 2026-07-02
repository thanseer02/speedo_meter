import 'package:permission_handler/permission_handler.dart';
import 'package:speedtrack/core/logger/log_helper.dart';
import 'package:speedtrack/exceptions/app_exceptions.dart';

/// Handles the strict sequential requesting of permissions.
class PermissionService {
  /// Checks and requests all required permissions for a workout.
  Future<void> requestWorkoutPermissions({bool requireBackground = false}) async {
    LogHelper.i('Requesting foreground location permission...');
    final foregroundStatus = await Permission.locationWhenInUse.request();
    
    if (foregroundStatus.isDenied || foregroundStatus.isPermanentlyDenied) {
      throw const PermissionDeniedException('Foreground location permission is required for tracking.');
    }

    if (requireBackground) {
      LogHelper.i('Requesting background location permission...');
      final backgroundStatus = await Permission.locationAlways.request();
      if (backgroundStatus.isDenied || backgroundStatus.isPermanentlyDenied) {
        throw const PermissionDeniedException('Background location permission is required for background tracking.');
      }
    }

    LogHelper.i('Requesting notification permission...');
    final notificationStatus = await Permission.notification.request();
    if (notificationStatus.isDenied || notificationStatus.isPermanentlyDenied) {
      LogHelper.w('Notification permission denied. The persistent workout notification will not be shown.');
    }
  }

  /// Check if GPS location services are enabled on the device.
  Future<bool> isLocationServiceEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }
}
