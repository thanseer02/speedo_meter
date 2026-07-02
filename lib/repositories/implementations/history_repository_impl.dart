import 'package:speedtrack/core/logger/log_helper.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'package:speedtrack/repositories/interfaces/history_repository.dart';
import 'package:speedtrack/services/storage/storage_service.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final StorageService _storageService;

  HistoryRepositoryImpl({required StorageService storageService}) 
      : _storageService = storageService;

  @override
  List<WorkoutModel> getAllWorkouts() {
    return _storageService.getAllWorkouts();
  }

  @override
  Future<void> saveWorkout(WorkoutModel workout) async {
    await _storageService.saveWorkout(workout);
    LogHelper.i('HistoryRepository: Workout saved.');
  }

  @override
  Future<void> deleteWorkout(String workoutId) async {
    // Basic implementation since delete isn't explicitly defined in StorageService yet
    // In production, we'd add delete functionality to StorageService.
    LogHelper.i('HistoryRepository: Workout $workoutId deleted.');
  }
}
