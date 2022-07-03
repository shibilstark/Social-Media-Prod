import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 3)
class PostLike {
  @HiveField(0)
  final String reecterId;
  @HiveField(1)
  final DateTime likedAt;

  PostLike({
    required this.reecterId,
    required this.likedAt,
  });
}
