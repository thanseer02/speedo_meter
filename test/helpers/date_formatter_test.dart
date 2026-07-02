import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/helpers/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('formatDuration formats minutes and seconds correctly', () {
      final duration = const Duration(minutes: 5, seconds: 30);
      expect(DateFormatter.formatDuration(duration), '05:30');
    });

    test('formatDuration formats hours, minutes and seconds correctly', () {
      final duration = const Duration(hours: 1, minutes: 5, seconds: 30);
      expect(DateFormatter.formatDuration(duration), '01:05:30');
    });

    test('formatPace formats pace string correctly', () {
      expect(DateFormatter.formatPace(330), '5:30 /km');
    });
    
    test('formatPace handles zero pace', () {
      expect(DateFormatter.formatPace(0), '0:00 /km');
    });
  });
}
