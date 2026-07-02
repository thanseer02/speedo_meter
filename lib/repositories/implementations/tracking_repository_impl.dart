import 'dart:async';
import 'package:speedtrack/core/logger/log_helper.dart';
import 'package:speedtrack/models/location_point.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'package:speedtrack/repositories/interfaces/tracking_repository.dart';
import 'package:speedtrack/services/background/background_tracking_service.dart';
import 'package:speedtrack/services/gps/location_service.dart';
import 'package:speedtrack/services/notifications/notification_service.dart';
import 'package:speedtrack/services/storage/storage_service.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final LocationService _locationService;
  final BackgroundTrackingService _backgroundService;
  final NotificationService _notificationService;
  final StorageService _storageService;

  StreamSubscription<LocationPoint>? _locationSubscription;
  WorkoutModel? _activeWorkout;

  final _locationController = StreamController<LocationPoint>.broadcast();

  TrackingRepositoryImpl({
    required LocationService locationService,
    required BackgroundTrackingService backgroundService,
    required NotificationService notificationService,
    required StorageService storageService,
  })  : _locationService = locationService,
        _backgroundService = backgroundService,
        _notificationService = notificationService,
        _storageService = storageService;

  @override
  Stream<LocationPoint> get locationStream => _locationController.stream;

  @override
  Future<void> startWorkout(WorkoutModel workout) async {
    _activeWorkout = workout;
    await _storageService.saveWorkout(workout);

    _locationSubscription = _locationService.startTracking().listen((point) {
      _locationController.add(point);
      // In a full implementation, we would update the active workout route and stats here
    });

    await _notificationService.showWorkoutNotification(
      title: 'SpeedTrack Active',
      body: 'Workout started...',
    );
    await _backgroundService.startService();
    LogHelper.i('TrackingRepository: Workout started successfully.');
  }

  @override
  Future<void> pauseWorkout() async {
    _locationSubscription?.pause();
    await _notificationService.showWorkoutNotification(
      title: 'SpeedTrack Paused',
      body: 'Workout paused. Tap to resume.',
    );
    LogHelper.i('TrackingRepository: Workout paused.');
  }

  @override
  Future<void> resumeWorkout() async {
    _locationSubscription?.resume();
    await _notificationService.showWorkoutNotification(
      title: 'SpeedTrack Active',
      body: 'Workout resumed...',
    );
    LogHelper.i('TrackingRepository: Workout resumed.');
  }

  @override
  Future<WorkoutModel> stopWorkout() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    
    _backgroundService.stopService();
    await _notificationService.cancelWorkoutNotification();
    
    if (_activeWorkout != null) {
      _activeWorkout = _activeWorkout!.copyWith(endTime: DateTime.now());
      await _storageService.saveWorkout(_activeWorkout!);
    }

    final finishedWorkout = _activeWorkout!;
    _activeWorkout = null;
    LogHelper.i('TrackingRepository: Workout stopped completely.');
    return finishedWorkout;
  }

  @override
  WorkoutModel? recoverActiveWorkout() {
    return _storageService.getActiveWorkout();
  }
}
