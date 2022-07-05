// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

class PostComment {
  final String commenterId;
  final DateTime date;
  final String commentText;

  PostComment({
    required this.commenterId,
    required this.date,
    required this.commentText,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commenterId': commenterId,
      'date': date.millisecondsSinceEpoch,
      'commentText': commentText,
    };
  }

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      commenterId: map['commenterId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      commentText: map['commentText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostComment.fromJson(String source) =>
      PostComment.fromMap(json.decode(source) as Map<String, dynamic>);
}
