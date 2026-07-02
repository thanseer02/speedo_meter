import 'package:flutter/material.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'package:speedtrack/repositories/interfaces/history_repository.dart';

class HistoryViewModel extends ChangeNotifier {
  final HistoryRepository _repository;

  HistoryViewModel({required HistoryRepository repository}) : _repository = repository;

  List<WorkoutModel> _workouts = [];
  List<WorkoutModel> get workouts => _workouts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadWorkouts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _workouts = _repository.getAllWorkouts();
      // Sort descending by date
      _workouts.sort((a, b) => b.startTime.compareTo(a.startTime));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWorkout(String id) async {
    await _repository.deleteWorkout(id);
    _workouts.removeWhere((w) => w.id == id);
    notifyListeners();
  }
}
