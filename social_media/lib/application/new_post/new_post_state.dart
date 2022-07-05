// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_post_bloc.dart';

class NewPostState extends Equatable {
  final NewPostEnum status;
  FilePickerResult? post;
  MainFailures? failure;
  PostType? postType;

  NewPostState(
      {required this.post,
      required this.status,
      required this.failure,
      required this.postType});
  @override
  List<Object?> get props => [status, post, postType];

  NewPostState copyWith({
    NewPostEnum? status,
    FilePickerResult? post,
    MainFailures? failure,
    PostType? postType,
  }) {
    return NewPostState(
      status: status ?? this.status,
      post: post ?? this.post,
      failure: failure ?? this.failure,
      postType: postType ?? this.postType,
    );
  }
}

class NewPostInitial extends NewPostState {
  NewPostInitial(
      {required FilePickerResult? post,
      required NewPostEnum status,
      required MainFailures? failure,
      required PostType? postType})
      : super(post: post, status: status, failure: failure, postType: postType);
  @override
  List<Object?> get props => [status, post, postType, failure];
}
