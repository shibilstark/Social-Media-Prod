// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      isAgreed: fields[4] as bool,
      isPrivate: fields[5] as bool,
      isBlocked: fields[6] as bool,
      creationDate: fields[7] as DateTime,
      followers: (fields[9] as List).cast<String>(),
      following: (fields[10] as List).cast<String>(),
      posts: (fields[11] as List).cast<String>(),
      discription: fields[12] as String,
      profileImage: fields[13] as String,
      coverImage: fields[3] as String,
      isEmailVerified: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.coverImage)
      ..writeByte(4)
      ..write(obj.isAgreed)
      ..writeByte(5)
      ..write(obj.isPrivate)
      ..writeByte(6)
      ..write(obj.isBlocked)
      ..writeByte(7)
      ..write(obj.creationDate)
      ..writeByte(8)
      ..write(obj.isEmailVerified)
      ..writeByte(9)
      ..write(obj.followers)
      ..writeByte(10)
      ..write(obj.following)
      ..writeByte(11)
      ..write(obj.posts)
      ..writeByte(12)
      ..write(obj.discription)
      ..writeByte(13)
      ..write(obj.profileImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
