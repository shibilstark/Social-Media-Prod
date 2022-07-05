part of 'new_post_bloc.dart';

abstract class NewPostEvent extends Equatable {}

class SelectPost extends NewPostEvent {
  final PostType type;

  SelectPost({required this.type});

  @override
  List<Object?> get props => [type];
}

class UploadPost extends NewPostEvent {
  final PostModel model;

  UploadPost({required this.model});

  @override
  List<Object?> get props => [model];
}
