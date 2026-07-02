import 'package:speedtrack/models/workout_model.dart';

abstract class HistoryRepository {
  /// Fetches all completed workouts
  List<WorkoutModel> getAllWorkouts();

  /// Saves a newly completed workout
  Future<void> saveWorkout(WorkoutModel workout);

  /// Deletes a specific workout
  Future<void> deleteWorkout(String workoutId);
}
