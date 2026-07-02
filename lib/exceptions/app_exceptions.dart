/// Base class for all custom application exceptions.
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AppException(this.message, {this.code, this.details});

  @override
  String toString() {
    return 'AppException: $message ${code != null ? '($code)' : ''}';
  }
}

/// Thrown when location permissions are denied by the user.
class PermissionDeniedException extends AppException {
  const PermissionDeniedException([
    super.message = 'Location permission denied',
  ]) : super(code: 'PERMISSION_DENIED');
}

/// Thrown when GPS services are disabled on the device.
class LocationDisabledException extends AppException {
  const LocationDisabledException([
    super.message = 'Location services are disabled',
  ]) : super(code: 'LOCATION_DISABLED');
}

/// Thrown when acquiring a GPS fix times out.
class GpsTimeoutException extends AppException {
  const GpsTimeoutException([
    super.message = 'Failed to acquire GPS signal in time',
  ]) : super(code: 'GPS_TIMEOUT');
}

/// Thrown when local storage operations fail.
class StorageException extends AppException {
  const StorageException(super.message, {super.details})
    : super(code: 'STORAGE_ERROR');
}

/// Thrown for general unexpected errors to ensure graceful failure.
class UnexpectedException extends AppException {
  const UnexpectedException(super.message, {super.details})
    : super(code: 'UNEXPECTED_ERROR');
}
