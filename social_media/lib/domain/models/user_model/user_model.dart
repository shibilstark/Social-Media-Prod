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
  String coverImage;
  @HiveField(4)
  bool isAgreed;
  @HiveField(5)
  bool isPrivate;
  @HiveField(6)
  bool isBlocked;
  @HiveField(7)
  DateTime creationDate;
  @HiveField(8)
  bool isEmailVerified;
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

  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.isAgreed,
      required this.isPrivate,
      required this.isBlocked,
      required this.creationDate,
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
      'coverImage': coverImage,
      'isAgreed': isAgreed,
      'isPrivate': isPrivate,
      'isBlocked': isBlocked,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'isEmailVerified': isEmailVerified,
      'followers': followers,
      'following': following,
      'posts': posts,
      'discription': discription,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      coverImage: map['coverImage'] as String,
      isAgreed: map['isAgreed'] as bool,
      isPrivate: map['isPrivate'] as bool,
      isBlocked: map['isBlocked'] as bool,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      isEmailVerified: map['isEmailVerified'] as bool,
      followers: List<String>.from((map['followers']) as List<dynamic>),
      following: List<String>.from((map['following']) as List<dynamic>),
      posts: List<String>.from((map['posts']) as List<dynamic>),
      discription: map['discription'] as String,
      profileImage: map['profileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? coverImage,
    bool? isAgreed,
    bool? isPrivate,
    bool? isBlocked,
    DateTime? creationDate,
    bool? isEmailVerified,
    List<String>? followers,
    List<String>? following,
    List<String>? posts,
    String? discription,
    String? profileImage,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      coverImage: coverImage ?? this.coverImage,
      isAgreed: isAgreed ?? this.isAgreed,
      isPrivate: isPrivate ?? this.isPrivate,
      isBlocked: isBlocked ?? this.isBlocked,
      creationDate: creationDate ?? this.creationDate,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      discription: discription ?? this.discription,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class UmKeys {
  static const String userId = "userId";
  static const String name = "name";
  static const String email = "email";
  static const String coverImage = "coverImage";
  static const String isAgreed = "isAgreed";
  static const String isPrivate = "isPrivate";
  static const String isBlocked = "isBlocked";
  static const String creationDate = "creationDate";
  static const String isEmailVerified = "isEmailVerified";
  static const String followers = "followers";
  static const String following = "following";
  static const String posts = "posts";
  static const String discription = "discription";
  static const String profileImage = "profileImage";
}
