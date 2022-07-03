import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 3)
class PostComment {
  @HiveField(0)
  final String reacterId;
  @HiveField(1)
  final DateTime commentedAt;
  @HiveField(2)
  final String commentText;

  PostComment(
      {required this.reacterId,
      required this.commentedAt,
      required this.commentText});
}
