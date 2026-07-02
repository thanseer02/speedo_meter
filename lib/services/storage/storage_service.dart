import 'package:hive_flutter/hive_flutter.dart';
import 'package:speedtrack/core/logger/log_helper.dart';
import 'package:speedtrack/enums/activity_type.dart';
import 'package:speedtrack/models/goal_model.dart';
import 'package:speedtrack/models/location_point.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'package:speedtrack/exceptions/app_exceptions.dart';

/// Centralized service for persisting data locally using Hive.
class StorageService {
  static const String workoutBoxName = 'workouts';
  static const String goalBoxName = 'goals';

  /// Initialize Hive and register adapters.
  Future<void> init() async {
    try {
      await Hive.initFlutter();
      
      // Register all generated adapters
      Hive.registerAdapter(ActivityTypeAdapter());
      Hive.registerAdapter(LocationPointAdapter());
      Hive.registerAdapter(GoalTypeAdapter());
      Hive.registerAdapter(GoalModelAdapter());
      Hive.registerAdapter(WorkoutModelAdapter());

      // Open boxes
      await Hive.openBox<WorkoutModel>(workoutBoxName);
      await Hive.openBox<GoalModel>(goalBoxName);
      LogHelper.i('StorageService initialized successfully.');
    } catch (e, stack) {
      LogHelper.e('Failed to initialize Hive', error: e, stackTrace: stack);
      throw StorageException('Local database initialization failed.');
    }
  }

  /// Save or update a workout session.
  Future<void> saveWorkout(WorkoutModel workout) async {
    try {
      final box = Hive.box<WorkoutModel>(workoutBoxName);
      await box.put(workout.id, workout);
    } catch (e, stack) {
      LogHelper.e('Failed to save workout', error: e, stackTrace: stack);
      throw const StorageException('Failed to save workout to local storage.');
    }
  }

  /// Retrieve all workouts.
  List<WorkoutModel> getAllWorkouts() {
    final box = Hive.box<WorkoutModel>(workoutBoxName);
    return box.values.toList();
  }

  /// Find an ongoing workout (useful for session recovery).
  WorkoutModel? getActiveWorkout() {
    final box = Hive.box<WorkoutModel>(workoutBoxName);
    try {
      return box.values.firstWhere((w) => w.isActive);
    } catch (e) {
      return null;
    }
  }
}
