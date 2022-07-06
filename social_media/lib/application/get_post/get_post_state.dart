// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_post_bloc.dart';

class GetPostState extends Equatable {
  final GetPostEnums status;
  final MainFailures? failure;
  final List<PostModel>? posts;
  final List<GlobalFeed>? feed;

  GetPostState(
      {required this.status,
      required this.failure,
      required this.posts,
      required this.feed});
  @override
  List<Object?> get props => [status, failure, posts];

  GetPostState copyWith({
    GetPostEnums? status,
    MainFailures? failure,
    List<PostModel>? posts,
    List<GlobalFeed>? feed,
  }) {
    return GetPostState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      posts: posts ?? this.posts,
      feed: feed ?? this.feed,
    );
  }
}

class GetPostInitial extends GetPostState {
  GetPostInitial({
    required GetPostEnums status,
    required MainFailures? failure,
    required List<PostModel>? posts,
    required List<GlobalFeed>? feed,
  }) : super(failure: failure, posts: posts, status: status, feed: feed);
  @override
  List<Object?> get props => [];
}
