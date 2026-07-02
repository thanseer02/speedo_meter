import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:speedtrack/core/logger/log_helper.dart';

/// Isolated entry point for the background service engine.
@pragma('vm:entry-point')
void onBackgroundStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  LogHelper.i('Background Tracking Service started in isolated process.');

  service.on('stopService').listen((event) {
    LogHelper.i('Received stop command in background service. Terminating...');
    service.stopSelf();
  });

  // Example ticker updating the foreground notification independently
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "SpeedTrack Active",
          content: "Tracking in progress... (${timer.tick}s)",
        );
      }
    }
  });
}

/// Orchestrates the background tracking lifecycle using flutter_background_service.
class BackgroundTrackingService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<void> initialize() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onBackgroundStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'workout_channel',
        initialNotificationTitle: 'SpeedTrack',
        initialNotificationContent: 'Preparing tracking...',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onBackgroundStart,
      ),
    );
  }

  Future<void> startService() async {
    LogHelper.i('Starting Background Tracking...');
    await _service.startService();
  }

  void stopService() {
    LogHelper.i('Stopping Background Tracking...');
    _service.invoke("stopService");
  }
}
