// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cred.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserIdAdapter extends TypeAdapter<UserId> {
  @override
  final int typeId = 4;

  @override
  UserId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserId(
      userID: fields[0] as String,
      email: fields[1] as String,
      pass: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserId obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.pass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
