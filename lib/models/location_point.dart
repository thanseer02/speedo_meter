import 'package:hive/hive.dart';

part 'location_point.g.dart';

/// Represents a single GPS coordinate tracked during a workout.
@HiveType(typeId: 1)
class LocationPoint {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final double altitude;

  @HiveField(3)
  final double speed;

  @HiveField(4)
  final double accuracy;

  @HiveField(5)
  final DateTime timestamp;

  LocationPoint({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
    required this.accuracy,
    required this.timestamp,
  });

  /// Factory constructor to easily create a placeholder or mock point.
  factory LocationPoint.empty() {
    return LocationPoint(
      latitude: 0.0,
      longitude: 0.0,
      altitude: 0.0,
      speed: 0.0,
      accuracy: 0.0,
      timestamp: DateTime.now(),
    );
  }
}
