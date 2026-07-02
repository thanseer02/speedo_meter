/// Utility methods for formatting dates, times, and durations.
class DateFormatter {
  DateFormatter._();

  /// Formats a [Duration] into `HH:mm:ss` or `mm:ss` if hours is 0.
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
    }
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  /// Formats a pace string given [secondsPerKm].
  static String formatPace(int secondsPerKm) {
    if (secondsPerKm <= 0) return "0:00 /km";
    final duration = Duration(seconds: secondsPerKm);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${duration.inMinutes}:$twoDigitSeconds /km';
  }
}
