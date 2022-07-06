part of 'get_post_bloc.dart';

abstract class GetPostEvent extends Equatable {}

class GetPost extends GetPostEvent {
  final String userId;
  GetPost({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetAllPostFeeds extends GetPostEvent {
  @override
  List<Object?> get props => [];
}
