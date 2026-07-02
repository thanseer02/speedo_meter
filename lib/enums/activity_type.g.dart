// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityTypeAdapter extends TypeAdapter<ActivityType> {
  @override
  final int typeId = 0;

  @override
  ActivityType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ActivityType.standing;
      case 1:
        return ActivityType.slowWalking;
      case 2:
        return ActivityType.walking;
      case 3:
        return ActivityType.fastWalking;
      case 4:
        return ActivityType.jogging;
      case 5:
        return ActivityType.running;
      case 6:
        return ActivityType.sprinting;
      default:
        return ActivityType.standing;
    }
  }

  @override
  void write(BinaryWriter writer, ActivityType obj) {
    switch (obj) {
      case ActivityType.standing:
        writer.writeByte(0);
        break;
      case ActivityType.slowWalking:
        writer.writeByte(1);
        break;
      case ActivityType.walking:
        writer.writeByte(2);
        break;
      case ActivityType.fastWalking:
        writer.writeByte(3);
        break;
      case ActivityType.jogging:
        writer.writeByte(4);
        break;
      case ActivityType.running:
        writer.writeByte(5);
        break;
      case ActivityType.sprinting:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
