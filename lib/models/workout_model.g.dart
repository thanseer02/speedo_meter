// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutModelAdapter extends TypeAdapter<WorkoutModel> {
  @override
  final int typeId = 4;

  @override
  WorkoutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutModel(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime?,
      distance: fields[3] as double,
      duration: fields[4] as Duration,
      movingTime: fields[5] as Duration,
      pauseTime: fields[6] as Duration,
      averageSpeed: fields[7] as double,
      maxSpeed: fields[8] as double,
      minSpeed: fields[9] as double,
      averagePace: fields[10] as int,
      calories: fields[11] as double,
      elevationGain: fields[12] as double,
      route: (fields[13] as List).cast<LocationPoint>(),
      activityType: fields[14] as ActivityType,
      notes: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.distance)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.movingTime)
      ..writeByte(6)
      ..write(obj.pauseTime)
      ..writeByte(7)
      ..write(obj.averageSpeed)
      ..writeByte(8)
      ..write(obj.maxSpeed)
      ..writeByte(9)
      ..write(obj.minSpeed)
      ..writeByte(10)
      ..write(obj.averagePace)
      ..writeByte(11)
      ..write(obj.calories)
      ..writeByte(12)
      ..write(obj.elevationGain)
      ..writeByte(13)
      ..write(obj.route)
      ..writeByte(14)
      ..write(obj.activityType)
      ..writeByte(15)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
