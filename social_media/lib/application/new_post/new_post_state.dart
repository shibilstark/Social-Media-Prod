// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_post_bloc.dart';

class NewPostState extends Equatable {
  final PostTypeModel? post;
  final String status;
  final MainFailures? failure;

  NewPostState(
      {required this.post, required this.status, required this.failure});

  @override
  List<Object?> get props => [post, status, failure];

  NewPostState copyWith({
    PostTypeModel? post,
    String? status,
    MainFailures? failure,
  }) {
    return NewPostState(
      post: post ?? this.post,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

class PostInitialState extends NewPostState {
  PostInitialState(
      {required PostTypeModel? post,
      required String status,
      required MainFailures? failure})
      : super(post: post, status: status, failure: failure);

  @override
  List<Object?> get props => [post, status, failure];
}
