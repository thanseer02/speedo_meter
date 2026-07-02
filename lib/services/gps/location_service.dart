import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:speedtrack/core/logger/log_helper.dart';
import 'package:speedtrack/exceptions/app_exceptions.dart';
import 'package:speedtrack/models/location_point.dart';

/// Wraps Geolocator to provide high-accuracy location tracking streams.
class LocationService {
  /// Start listening to location updates.
  Stream<LocationPoint> startTracking({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 2,
  }) {
    LogHelper.i('Starting GPS tracking stream...');
    
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    ).map((Position position) {
      return LocationPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude,
        speed: position.speed,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    }).handleError((error) {
      LogHelper.e('GPS Tracking Error', error: error);
      throw UnexpectedException('Lost connection to GPS hardware.', details: error);
    });
  }

  /// Get the user's current location immediately.
  Future<LocationPoint> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
      );
      return LocationPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude,
        speed: position.speed,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    } on TimeoutException {
      throw const GpsTimeoutException();
    } catch (e) {
      throw const LocationDisabledException();
    }
  }
}
