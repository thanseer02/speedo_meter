/// Global application configurations and constants.
class AppConfigs {
  AppConfigs._();

  static const String appName = 'SpeedTrack';
  static const String appVersion = '1.0.0';
  
  // Timeouts
  static const Duration locationTimeout = Duration(seconds: 15);
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
}
