import 'package:speedtrack/models/location_point.dart';
import 'package:speedtrack/models/workout_model.dart';

abstract class TrackingRepository {
  /// Stream of raw, high-accuracy GPS points
  Stream<LocationPoint> get locationStream;

  /// Start a brand new tracking session
  Future<void> startWorkout(WorkoutModel workout);

  /// Pause an active session
  Future<void> pauseWorkout();

  /// Resume a paused session
  Future<void> resumeWorkout();

  /// Stop and finalize the session
  Future<WorkoutModel> stopWorkout();

  /// Gets the currently active workout from storage, if any (used for recovery)
  WorkoutModel? recoverActiveWorkout();
}
