// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/models/comment/comment_model.dart';
import 'package:social_media/domain/models/like/like_model.dart';
import 'package:social_media/domain/models/report/report_model.dart';

class PostModel {
  final String userId;
  final String post;
  final String id;
  final DateTime creationData;
  final List<PostComment> comments;
  final List<PostLights> lights;
  final PostType type;
  final List<PostReport> reports;
  final DateTime lastUpdate;
  final BoxFit? fit;

  PostModel(
      {required this.userId,
      required this.post,
      required this.id,
      required this.creationData,
      required this.comments,
      required this.lights,
      required this.type,
      required this.reports,
      required this.lastUpdate,
      required this.fit});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'post': post,
      'id': id,
      'creationData': creationData.millisecondsSinceEpoch,
      'comments': comments.map((x) => x.toMap()).toList(),
      'lights': lights.map((x) => x.toMap()).toList(),
      'type': type.name,
      'reports': reports.map((x) => x.toMap()).toList(),
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'] as String,
      post: map['post'] as String,
      id: map['id'] as String,
      creationData:
          DateTime.fromMillisecondsSinceEpoch(map['creationData'] as int),
      comments: List<PostComment>.from(
        (map['comments'] as List<int>).map<PostComment>(
          (x) => PostComment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lights: List<PostLights>.from(
        (map['lights'] as List<int>).map<PostLights>(
          (x) => PostLights.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: map['type'] as PostType,
      reports: List<PostReport>.from(
        (map['reports'] as List<int>).map<PostReport>(
          (x) => PostReport.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(map['lastUpdate'] as int),
      fit: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? userId,
    String? post,
    String? id,
    DateTime? creationData,
    List<PostComment>? comments,
    List<PostLights>? lights,
    PostType? type,
    List<PostReport>? reports,
    DateTime? lastUpdate,
    BoxFit? fit,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      post: post ?? this.post,
      id: id ?? this.id,
      creationData: creationData ?? this.creationData,
      comments: comments ?? this.comments,
      lights: lights ?? this.lights,
      type: type ?? this.type,
      reports: reports ?? this.reports,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      fit: fit ?? this.fit,
    );
  }
}
