import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:speedtrack/models/location_point.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'package:speedtrack/repositories/interfaces/tracking_repository.dart';
import 'package:speedtrack/services/permissions/permission_service.dart';
import 'package:speedtrack/core/logger/log_helper.dart';

enum TrackingState { idle, active, paused }

class TrackingViewModel extends ChangeNotifier {
  final TrackingRepository _repository;
  final PermissionService _permissionService;

  TrackingViewModel({
    required TrackingRepository repository,
    required PermissionService permissionService,
  })  : _repository = repository,
        _permissionService = permissionService {
    _recoverState();
  }

  TrackingState _state = TrackingState.idle;
  TrackingState get state => _state;

  WorkoutModel? _currentWorkout;
  WorkoutModel? get currentWorkout => _currentWorkout;

  LocationPoint? _lastLocation;
  LocationPoint? get lastLocation => _lastLocation;

  StreamSubscription<LocationPoint>? _locationSub;

  Future<void> _recoverState() async {
    final recovered = _repository.recoverActiveWorkout();
    if (recovered != null) {
      _currentWorkout = recovered;
      _state = TrackingState.paused; // Recovered sessions start paused safely
      LogHelper.i('TrackingViewModel: Recovered active workout: ${recovered.id}');
      notifyListeners();
    }
  }

  Future<void> startWorkout() async {
    try {
      await _permissionService.requestWorkoutPermissions(requireBackground: true);
    } catch (e) {
      LogHelper.e('Permission denied when starting workout: $e');
      rethrow; // UI should catch this and show a dialog
    }

    final newWorkout = WorkoutModel(
      id: const Uuid().v4(),
      startTime: DateTime.now(),
    );

    await _repository.startWorkout(newWorkout);
    _currentWorkout = newWorkout;
    _state = TrackingState.active;
    
    _listenToLocations();
    notifyListeners();
  }

  Future<void> pauseWorkout() async {
    if (_state != TrackingState.active) return;
    
    await _repository.pauseWorkout();
    _locationSub?.pause();
    _state = TrackingState.paused;
    notifyListeners();
  }

  Future<void> resumeWorkout() async {
    if (_state != TrackingState.paused) return;

    await _repository.resumeWorkout();
    _locationSub?.resume();
    _state = TrackingState.active;
    notifyListeners();
  }

  Future<void> stopWorkout() async {
    if (_state == TrackingState.idle) return;

    final finished = await _repository.stopWorkout();
    await _locationSub?.cancel();
    _locationSub = null;
    
    _currentWorkout = null;
    _lastLocation = null;
    _state = TrackingState.idle;
    LogHelper.i('TrackingViewModel: Finished workout with distance: ${finished.distance}');
    notifyListeners();
  }

  void _listenToLocations() {
    _locationSub = _repository.locationStream.listen((point) {
      _lastLocation = point;
      
      if (_currentWorkout != null) {
        // Here we would run distance formulas between points
        // Simplified for now, just appending the point
        final updatedRoute = List<LocationPoint>.from(_currentWorkout!.route)..add(point);
        _currentWorkout = _currentWorkout!.copyWith(
          route: updatedRoute,
        );
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _locationSub?.cancel();
    super.dispose();
  }
}
