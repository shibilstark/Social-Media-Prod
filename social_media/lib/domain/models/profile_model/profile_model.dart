import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class ProfileModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String? discription;
  @HiveField(4)
  bool isPrivate;
  @HiveField(5)
  DateTime creationDate;
  @HiveField(6)
  List<String> followers;
  @HiveField(7)
  List<String> following;
  @HiveField(8)
  List<String> posts;

  ProfileModel({
    required this.name,
    required this.email,
    this.discription,
    required this.creationDate,
    required this.isPrivate,
    required this.userId,
    required this.followers,
    required this.following,
    required this.posts,
  });
}
