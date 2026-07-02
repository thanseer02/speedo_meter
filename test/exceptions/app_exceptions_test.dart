import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/exceptions/app_exceptions.dart';

void main() {
  group('AppExceptions', () {
    test('PermissionDeniedException has correct defaults', () {
      final ex = const PermissionDeniedException();
      expect(ex.message, 'Location permission denied');
      expect(ex.code, 'PERMISSION_DENIED');
      expect(ex.toString(), 'AppException: Location permission denied (PERMISSION_DENIED)');
    });

    test('GpsTimeoutException has correct code', () {
      final ex = const GpsTimeoutException('Custom msg');
      expect(ex.message, 'Custom msg');
      expect(ex.code, 'GPS_TIMEOUT');
    });
  });
}
