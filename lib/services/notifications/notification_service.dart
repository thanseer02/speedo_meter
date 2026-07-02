import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:speedtrack/core/logger/log_helper.dart';

/// Handles foreground notifications to keep the app alive during a workout.
class NotificationService {
  static const int workoutNotificationId = 888;
  static const String channelId = 'workout_channel';
  static const String channelName = 'Active Workout Tracking';

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _plugin.initialize(settings: initializationSettings);
  }

  /// Show the non-dismissible ongoing notification.
  Future<void> showWorkoutNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Maintains background location tracking',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      autoCancel: false,
      showWhen: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      id: workoutNotificationId,
      title: title,
      body: body,
      notificationDetails: platformDetails,
    );
    LogHelper.t('Updated workout notification: $body');
  }

  /// Remove the notification when the workout ends.
  Future<void> cancelWorkoutNotification() async {
    await _plugin.cancel(id: workoutNotificationId);
    LogHelper.i('Workout notification cancelled.');
  }
}
