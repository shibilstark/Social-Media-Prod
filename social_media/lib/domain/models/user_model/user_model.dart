// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  bool isAgreed;
  @HiveField(5)
  bool isPrivate;
  @HiveField(6)
  bool isBlocked;
  @HiveField(7)
  DateTime creationDate;
  @HiveField(8)
  bool isVerified;
  @HiveField(9)
  List<String> followers;
  @HiveField(10)
  List<String> following;
  @HiveField(11)
  List<String> posts;
  @HiveField(12)
  String discription;
  @HiveField(13)
  String profileImage;
  @HiveField(14)
  String coverImage;
  @HiveField(15)
  bool isEmailVerified;

  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.password,
      required this.isAgreed,
      required this.isPrivate,
      required this.isBlocked,
      required this.creationDate,
      required this.isVerified,
      required this.followers,
      required this.following,
      required this.posts,
      required this.discription,
      required this.profileImage,
      required this.coverImage,
      required this.isEmailVerified});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'isAgreed': isAgreed,
      'isPrivate': isPrivate,
      'isBlocked': isBlocked,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'isVerified': isVerified,
      'followers': followers,
      'following': following,
      'posts': posts,
      'discription': discription,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isAgreed: map['isAgreed'] as bool,
      isPrivate: map['isPrivate'] as bool,
      isBlocked: map['isBlocked'] as bool,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      isVerified: map['isVerified'] as bool,
      followers: List<String>.from((map['followers'] as List<dynamic>)),
      following: List<String>.from((map['following'] as List<dynamic>)),
      posts: List<String>.from((map['posts'] as List<dynamic>)),
      discription: map['discription'] as String,
      profileImage: map['profileImage'] as String,
      coverImage: map['coverImage'] as String,
      isEmailVerified: map['isEmailVerified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
