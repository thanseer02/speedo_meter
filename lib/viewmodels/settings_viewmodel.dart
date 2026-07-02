import 'package:flutter/material.dart';
import 'package:speedtrack/repositories/interfaces/settings_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository;

  SettingsViewModel({required SettingsRepository repository}) : _repository = repository {
    _loadSettings();
  }

  bool _isBackgroundTrackingEnabled = false;
  bool get isBackgroundTrackingEnabled => _isBackgroundTrackingEnabled;

  bool _isAutoPauseEnabled = false;
  bool get isAutoPauseEnabled => _isAutoPauseEnabled;

  bool _isMetricUnitsEnabled = true;
  bool get isMetricUnitsEnabled => _isMetricUnitsEnabled;

  Future<void> _loadSettings() async {
    _isBackgroundTrackingEnabled = await _repository.getIsBackgroundTrackingEnabled();
    _isAutoPauseEnabled = await _repository.getIsAutoPauseEnabled();
    _isMetricUnitsEnabled = await _repository.getIsMetricUnitsEnabled();
    notifyListeners();
  }

  Future<void> setBackgroundTracking(bool value) async {
    await _repository.setIsBackgroundTrackingEnabled(value);
    _isBackgroundTrackingEnabled = value;
    notifyListeners();
  }

  Future<void> setAutoPause(bool value) async {
    await _repository.setIsAutoPauseEnabled(value);
    _isAutoPauseEnabled = value;
    notifyListeners();
  }

  Future<void> setMetricUnits(bool value) async {
    await _repository.setIsMetricUnitsEnabled(value);
    _isMetricUnitsEnabled = value;
    notifyListeners();
  }
}
