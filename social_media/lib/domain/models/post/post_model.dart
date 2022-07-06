// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
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
  final dynamic type;
  final List<PostReport> reports;
  final DateTime lastUpdate;
  final String? fit;
  final String? dicription;
  final String? tag;

  PostModel(
      {required this.userId,
      required this.post,
      required this.dicription,
      required this.id,
      required this.creationData,
      required this.comments,
      required this.lights,
      required this.type,
      required this.reports,
      required this.lastUpdate,
      required this.fit,
      required this.tag});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'post': post,
      'id': id,
      'creationData': creationData.millisecondsSinceEpoch,
      'comments': comments.map((x) => x.toMap()).toList(),
      'lights': lights.map((x) => x.toMap()).toList(),
      'type': type as String,
      'reports': reports.map((x) => x.toMap()).toList(),
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
      "fit": fit as String,
      'dicription': dicription as String,
      'tag': tag as String
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      tag: map['tag'] as String,
      dicription: map['dicription'] as String,
      userId: map['userId'] as String,
      post: map['post'] as String,
      id: map['id'] as String,
      creationData:
          DateTime.fromMillisecondsSinceEpoch(map['creationData'] as int),
      comments: List<PostComment>.from(
        (map['comments'] as List<dynamic>).map<PostComment>(
          (x) => PostComment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lights: List<PostLights>.from(
        (map['lights'] as List<dynamic>).map<PostLights>(
          (x) => PostLights.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: map['type'] as String,
      reports: List<PostReport>.from(
        (map['reports'] as List<dynamic>).map<PostReport>(
          (x) => PostReport.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(map['lastUpdate'] as int),
      fit: map["fit"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith(
      {String? userId,
      String? post,
      String? id,
      DateTime? creationData,
      List<PostComment>? comments,
      List<PostLights>? lights,
      PostType? type,
      List<PostReport>? reports,
      DateTime? lastUpdate,
      String? fit,
      String? dicription,
      String? tag}) {
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
        dicription: dicription ?? this.dicription,
        tag: tag ?? this.tag);
  }
}
