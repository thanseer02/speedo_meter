import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedtrack/repositories/interfaces/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _keyBackgroundTracking = 'pref_background_tracking';
  static const String _keyAutoPause = 'pref_auto_pause';
  static const String _keyHighAccuracyGps = 'pref_high_accuracy_gps';
  static const String _keyMetricUnits = 'pref_metric_units';

  @override
  Future<bool> getIsBackgroundTrackingEnabled() async {
    return _prefs.getBool(_keyBackgroundTracking) ?? false;
  }

  @override
  Future<void> setIsBackgroundTrackingEnabled(bool value) async {
    await _prefs.setBool(_keyBackgroundTracking, value);
  }

  @override
  Future<bool> getIsAutoPauseEnabled() async {
    return _prefs.getBool(_keyAutoPause) ?? false;
  }

  @override
  Future<void> setIsAutoPauseEnabled(bool value) async {
    await _prefs.setBool(_keyAutoPause, value);
  }

  @override
  Future<bool> getIsHighAccuracyGpsEnabled() async {
    return _prefs.getBool(_keyHighAccuracyGps) ?? true;
  }

  @override
  Future<void> setIsHighAccuracyGpsEnabled(bool value) async {
    await _prefs.setBool(_keyHighAccuracyGps, value);
  }

  @override
  Future<bool> getIsMetricUnitsEnabled() async {
    return _prefs.getBool(_keyMetricUnits) ?? true;
  }

  @override
  Future<void> setIsMetricUnitsEnabled(bool value) async {
    await _prefs.setBool(_keyMetricUnits, value);
  }
}
