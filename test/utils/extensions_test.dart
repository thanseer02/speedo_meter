import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/utils/extensions.dart';

void main() {
  group('StringExtensions', () {
    test('capitalizeFirst capitalizes the first letter', () {
      expect('hello'.capitalizeFirst(), 'Hello');
    });

    test('capitalizeFirst returns empty string if empty', () {
      expect(''.capitalizeFirst(), '');
    });
  });

  group('DoubleExtensions', () {
    test('toSpeedString formats to 1 decimal place', () {
      expect(5.1234.toSpeedString(), '5.1');
      expect(5.0.toSpeedString(), '5.0');
    });

    test('toDistanceString formats to 2 decimal places', () {
      expect(10.1234.toDistanceString(), '10.12');
      expect(10.0.toDistanceString(), '10.00');
    });
  });
}
