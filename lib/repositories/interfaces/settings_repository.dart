abstract class SettingsRepository {
  Future<bool> getIsBackgroundTrackingEnabled();
  Future<void> setIsBackgroundTrackingEnabled(bool value);

  Future<bool> getIsAutoPauseEnabled();
  Future<void> setIsAutoPauseEnabled(bool value);

  Future<bool> getIsHighAccuracyGpsEnabled();
  Future<void> setIsHighAccuracyGpsEnabled(bool value);

  Future<bool> getIsMetricUnitsEnabled();
  Future<void> setIsMetricUnitsEnabled(bool value);
}
