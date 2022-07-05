// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:social_media/core/constants/enums.dart';

class PostReport {
  final String postId;
  final String reporter;
  final String postOwner;
  final ReportsType type;

  PostReport({
    required this.postId,
    required this.reporter,
    required this.postOwner,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'reporter': reporter,
      'postOwner': postOwner,
      'type': type,
    };
  }

  factory PostReport.fromMap(Map<String, dynamic> map) {
    return PostReport(
      postId: map['postId'] as String,
      reporter: map['reporter'] as String,
      postOwner: map['postOwner'] as String,
      type: map["type"] as ReportsType,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostReport.fromJson(String source) =>
      PostReport.fromMap(json.decode(source) as Map<String, dynamic>);
}
