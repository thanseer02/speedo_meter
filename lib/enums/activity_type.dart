import 'package:hive/hive.dart';

part 'activity_type.g.dart';

@HiveType(typeId: 0)
enum ActivityType {
  @HiveField(0)
  standing,
  @HiveField(1)
  slowWalking,
  @HiveField(2)
  walking,
  @HiveField(3)
  fastWalking,
  @HiveField(4)
  jogging,
  @HiveField(5)
  running,
  @HiveField(6)
  sprinting,
}
