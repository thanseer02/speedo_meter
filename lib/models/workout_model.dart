import 'package:hive/hive.dart';
import 'package:speedtrack/enums/activity_type.dart';
import 'package:speedtrack/models/location_point.dart';

part 'workout_model.g.dart';

/// Represents a complete tracked workout session.
@HiveType(typeId: 4)
class WorkoutModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime? endTime;

  @HiveField(3)
  final double distance;

  @HiveField(4)
  final int durationMs;

  @HiveField(5)
  final int movingTimeMs;

  @HiveField(6)
  final int pauseTimeMs;

  @HiveField(7)
  final double averageSpeed;

  @HiveField(8)
  final double maxSpeed;

  @HiveField(9)
  final double minSpeed;

  @HiveField(10)
  final int averagePace; // Stored in seconds per km

  @HiveField(11)
  final double calories;

  @HiveField(12)
  final double elevationGain;

  @HiveField(13)
  final List<LocationPoint> route;

  @HiveField(14)
  final ActivityType activityType;

  @HiveField(15)
  final String notes;

  WorkoutModel({
    required this.id,
    required this.startTime,
    this.endTime,
    this.distance = 0.0,
    this.durationMs = 0,
    this.movingTimeMs = 0,
    this.pauseTimeMs = 0,
    this.averageSpeed = 0.0,
    this.maxSpeed = 0.0,
    this.minSpeed = 0.0,
    this.averagePace = 0,
    this.calories = 0.0,
    this.elevationGain = 0.0,
    this.route = const [],
    this.activityType = ActivityType.walking,
    this.notes = '',
  });

  /// True if the workout is currently ongoing (end time is null).
  bool get isActive => endTime == null;

  Duration get duration => Duration(milliseconds: durationMs);
  Duration get movingTime => Duration(milliseconds: movingTimeMs);
  Duration get pauseTime => Duration(milliseconds: pauseTimeMs);

  /// Returns a copy of this workout with updated fields.
  WorkoutModel copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    double? distance,
    int? durationMs,
    int? movingTimeMs,
    int? pauseTimeMs,
    double? averageSpeed,
    double? maxSpeed,
    double? minSpeed,
    int? averagePace,
    double? calories,
    double? elevationGain,
    List<LocationPoint>? route,
    ActivityType? activityType,
    String? notes,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distance: distance ?? this.distance,
      durationMs: durationMs ?? this.durationMs,
      movingTimeMs: movingTimeMs ?? this.movingTimeMs,
      pauseTimeMs: pauseTimeMs ?? this.pauseTimeMs,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      minSpeed: minSpeed ?? this.minSpeed,
      averagePace: averagePace ?? this.averagePace,
      calories: calories ?? this.calories,
      elevationGain: elevationGain ?? this.elevationGain,
      route: route ?? this.route,
      activityType: activityType ?? this.activityType,
      notes: notes ?? this.notes,
    );
  }
}
