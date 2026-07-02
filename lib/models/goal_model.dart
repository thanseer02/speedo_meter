import 'package:hive/hive.dart';

part 'goal_model.g.dart';

/// Types of goals a user can set.
@HiveType(typeId: 2)
enum GoalType {
  @HiveField(0)
  distance,
  @HiveField(1)
  time,
  @HiveField(2)
  calories,
}

/// Represents a user-configured goal (e.g., Daily Distance, Weekly Time).
@HiveType(typeId: 3)
class GoalModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final GoalType type;

  @HiveField(2)
  final double targetValue;

  @HiveField(3)
  final double currentValue;

  @HiveField(4)
  final bool isCompleted;

  GoalModel({
    required this.id,
    required this.type,
    required this.targetValue,
    this.currentValue = 0.0,
    this.isCompleted = false,
  });

  /// Returns a copy of this goal with updated values.
  GoalModel copyWith({
    String? id,
    GoalType? type,
    double? targetValue,
    double? currentValue,
    bool? isCompleted,
  }) {
    return GoalModel(
      id: id ?? this.id,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
